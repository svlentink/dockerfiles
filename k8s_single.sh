#!/bin/bash -e

# STATUS: WIP

# based on
# https://medium.com/@smijar/installing-kubernetes-all-in-one-on-a-low-resource-vps-1c89dd5f0096
# https://hostadvice.com/how-to/how-to-set-up-kubernetes-in-ubuntu/
# https://ninetaillabs.com/setting-up-a-single-node-kubernetes-cluster/

disable_swap() {
  swapoff -a
  grep -v swap /etc/fstab > /etc/fstab.noswap
  mv /etc/fstab /etc/fstab.swap
  mv /etc/fstab.noswap /etc/fstab
}
install_docker_long() { # https://kubernetes.io/docs/setup/independent/install-kubeadm/#installing-docker
  apt -y install \
    apt-transport-https \
    ca-certificates \
    software-properties-common \
    curl
  
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
  add-apt-repository "deb https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") $(lsb_release -cs) stable"
  
  apt update
  apt install -y \
    docker-ce=$(apt-cache madison docker-ce | grep 17.03 | head -1 | awk '{print $3}')
}
install_docker() {
  apt install -y \
    docker.io
}
install_kubeadm() { # https://kubernetes.io/docs/setup/independent/install-kubeadm/#installing-kubeadm-kubelet-and-kubectl
  curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
  add-apt-repository "deb https://apt.kubernetes.io/ kubernetes-$(lsb_release -cs) main"
  apt update
  apt install -y \
    kubelet \
    kubeadm \
    kubernetes-cni
  #apt-mark hold kubelet kubeadm kubectl
}
init_master() { #https://kubernetes.io/docs/setup/independent/create-cluster-kubeadm/#initializing-your-master
  echo y|kubeadm reset
  #https://stackoverflow.com/questions/44305615/pods-are-not-starting-networkplugin-cni-failed-to-set-up-pod
  kubeadm init \
    --apiserver-advertise-address=$IPADDR
#    --pod-network-cidr=10.224.0.0/16

  mkdir -p $HOME/.kube 
  cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  chown $(id -u):$(id -g) $HOME/.kube/config
  
  #https://kubernetes.io/docs/setup/independent/create-cluster-kubeadm/#more-information
  #https://github.com/kubernetes/kubernetes/issues/48378
  export KUBECONFIG=/etc/kubernetes/kubelet.conf
  sleep 120 # just to be sure the master is all fired up
  kubectl get pods --all-namespaces|grep dns|grep -i running||(echo init_master failed && exit)
}
deploy_flannel() { #https://kubernetes.io/docs/setup/independent/create-cluster-kubeadm/#pod-network
  sysctl net.bridge.bridge-nf-call-iptables=1
  kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/k8s-manifests/kube-flannel-rbac.yml
  kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
}
deploy_weave() { #https://kubernetes.io/docs/setup/independent/create-cluster-kubeadm/#pod-network
  echo "net.bridge.bridge-nf-call-iptables=1" >> /etc/sysctl.conf
  sysctl -p
  sleep 10
  kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"
  sleep 120
  kubectl get pods --all-namespaces|grep weave|grep -i running||(echo deploy_weave failed && exit)
}
disable_master_isolation() { #https://kubernetes.io/docs/setup/independent/create-cluster-kubeadm/#master-isolation
  kubectl taint nodes --all node-role.kubernetes.io/master-
}
install_dashboard() { #https://github.com/kubernetes/dashboard#getting-started
  kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/master/src/deploy/recommended/kubernetes-dashboard.yaml
  # https://github.com/kubernetes/dashboard/wiki/Access-control#official-release
cat <<EOF> /tmp/dashboard-admin.yaml
apiVersion: rbac.authorization.k8s.io/v1beta1
kind: ClusterRoleBinding
metadata:
  name: kubernetes-dashboard
  labels:
    k8s-app: kubernetes-dashboard
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
- kind: ServiceAccount
  name: kubernetes-dashboard
  namespace: kube-system
EOF
cat <<EOF> /tmp/service-account.yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: kubernetes-dashboard
  namespace: kube-system
EOF

  kubectl create -f /tmp/service-account.yaml
  kubectl create -f /tmp/dashboard-admin.yaml
  
  sleep 60
  kubectl get pods --all-namespaces|grep dashboard|grep -i running||(echo install_dashboard failed && exit)
  
  DASHBOARD_TOKEN_NAME=`kubectl -n kube-system get secret|grep dashboard-token|awk '{print $1}'`
  kubectl -n kube-system describe secret ${DASHBOARD_TOKEN_NAME}
}


function_for_safe_piping() {
echo Create single instance k8s master and node

[[ $USER != "root" ]] && echo Please run as root && exit 1

ip a
echo "The current hostname is "$(hostname)" if you want to change this, hit CTRL-C"
read -p "Please provide the (public) IP of this machine, on which you'll connect to webui/API-endpoint:" IPADDR

echo Installing curl etc.
apt update
apt install -y \
  apt-transport-https \
  curl \
  tmux \
  vim

echo => Installing deps and k8s
disable_swap
install_docker
install_kubeadm
echo ==> Init master
init_master
echo ===> Deploying pod network
deploy_weave
disable_master_isolation
echo ====> Installing dashboard
install_dashboard

update-grub || true

kubectl get pods --all-namespaces

echo "debugging: kubectl describe po -n kube-system"
echo "kubectl proxy -p 8080 --accept-hosts='^*\$' --address="$IPADDR
#https://kubernetes.io/docs/tasks/access-application-cluster/web-ui-dashboard/#master-server
echo "http://$IPADDR:8080/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/"
}
function_for_safe_piping
