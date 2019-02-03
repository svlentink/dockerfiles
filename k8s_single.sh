#!/bin/bash -e
set -e


install_microk8s() {
  apt update
  apt upgrade -y
  apt install -y \
    apt-transport-https \
    curl \
    sudo \
    tmux \
    vim
  snap install microk8s --classic
  sleep 120
  microk8s.start
  microk8s.status
  which kubectl || snap alias microk8s.kubectl kubectl
  microk8s.enable dashboard dns
  
  kubectl get all --all-namespaces
  kubectl cluster-info
}

echo please try microk8s
echo see https://blog.lent.ink/tags/kubernetes
exit

deprecated_install_kubectl() {
  # https://kubernetes.io/docs/tasks/tools/install-kubectl/#install-kubectl-binary-using-native-package-management
  apt update
  apt install -y apt-transport-https
  curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
  echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list
  apt update
  apt install -y kubectl
}
deprecated_install_docker_long() { # https://kubernetes.io/docs/setup/independent/install-kubeadm/#installing-docker
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
  systemctl enable docker
  systemctl start docker
}
deprecated_install_kubeadm() { # https://kubernetes.io/docs/setup/independent/install-kubeadm/#installing-kubeadm-kubelet-and-kubectl
  curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
  
  local DIST=kubernetes-$(lsb_release -cs)
  if [ curl --silent https://packages.cloud.google.com/apt/dists|grep $DIST ]; then
    echo using $DIST
  else
    echo $DIST not found
    local DIST=kubernetes-stretch
    echo using $DIST
  fi
  
  add-apt-repository "deb https://apt.kubernetes.io/ $DIST main"
  apt update
  apt install -y \
    kubelet \
    kubeadm \
    kubernetes-cni
  #apt-mark hold kubelet kubeadm kubectl
}


disable_swap() {
  swapoff -a
  grep -v swap /etc/fstab > /etc/fstab.noswap
  mv /etc/fstab /etc/fstab.swap
  mv /etc/fstab.noswap /etc/fstab
}
install_kubeadm() {
#https://kubernetes.io/docs/setup/independent/install-kubeadm/#installing-kubeadm-kubelet-and-kubectl
apt-get update && apt-get install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
apt-get update
apt-get install -y kubelet kubeadm kubectl
}



init_master() { #https://kubernetes.io/docs/setup/independent/create-cluster-kubeadm/#initializing-your-master
  echo y|kubeadm reset
  #https://stackoverflow.com/questions/44305615/pods-are-not-starting-networkplugin-cni-failed-to-set-up-pod

# if the following fails: https://github.com/kubernetes/kubernetes/issues/67933
  kubeadm init
#    --apiserver-advertise-address=$IPADDR
#    --pod-network-cidr=10.224.0.0/16

  mkdir -p $HOME/.kube 
  cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  chown $(id -u):$(id -g) $HOME/.kube/config
  
  #https://kubernetes.io/docs/setup/independent/create-cluster-kubeadm/#more-information
  #https://github.com/kubernetes/kubernetes/issues/48378
  export KUBECONFIG=/etc/kubernetes/kubelet.conf
  sleep 120 # just to be sure the master is all fired up
}
deploy_flannel() { #https://kubernetes.io/docs/setup/independent/create-cluster-kubeadm/#pod-network
  sysctl net.bridge.bridge-nf-call-iptables=1
  kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/k8s-manifests/kube-flannel-rbac.yml
  kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
}
deploy_weave() { #https://kubernetes.io/docs/setup/independent/create-cluster-kubeadm/#pod-network
  echo "net.bridge.bridge-nf-call-iptables=1" >> /etc/sysctl.conf
  sysctl -p
  #kubectl create clusterrolebinding weave-net --clusterrole=cluster-admin --user=myname@example.org
  kubectl create clusterrolebinding cluster-admin-binding --clusterrole cluster-admin --user $USER
  sleep 120
  kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"
  sleep 120
  kubectl get pods --all-namespaces|grep weave|grep -i running||(echo deploy_weave failed && exit)
}
disable_master_isolation() { #https://kubernetes.io/docs/setup/independent/create-cluster-kubeadm/#master-isolation
  kubectl taint nodes --all node-role.kubernetes.io/master-
}
install_dashboard() { #https://github.com/kubernetes/dashboard#getting-started
  dpkg --print-architecture|grep arm && ARMSTRING='-arm'
  kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/master/src/deploy/recommended/kubernetes-dashboard$ARMSTRING.yaml
  # https://github.com/kubernetes/dashboard/wiki/Access-control#official-release
cat <<EOF> /tmp/dashboard-admin.yaml
apiVersion: rbac.authorization.k8s.io/v1beta1
kind: ClusterRoleBinding
metadata:
  name: admin-user
  labels:
    k8s-app: kubernetes-dashboard
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
- kind: ServiceAccount
  name: admin-user
  namespace: kube-system
EOF
cat <<EOF> /tmp/service-account.yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: admin-user
  namespace: kube-system
EOF

  kubectl create -f /tmp/service-account.yaml
  kubectl create -f /tmp/dashboard-admin.yaml
  
  sleep 60
  kubectl get pods --all-namespaces|grep dashboard|grep -i running||(echo install_dashboard failed && exit)
  
  DASHBOARD_TOKEN_NAME=`kubectl -n kube-system get secret|grep dashboard-token|awk '{print $1}'`
  kubectl -n kube-system describe secret ${DASHBOARD_TOKEN_NAME}
}

# Have tested it on ARM 64bit, which gave errors, not sure if they were x86 compatible
dpkg --print-architecture|grep arm && echo "Detected ARM architecture. Dashboard won't work."

echo Create single instance k8s master and node

[[ $USER != "root" ]] && echo Please run as root && exit 1

echo "The current hostname is "$(hostname)" if you want to change this, hit CTRL-C"

if [[ -z "$PUBLIC_IPv4" ]]; then
  ip a
  read -p "Please provide the (public) IP of this machine, on which you'll connect to webui/API-endpoint:" IPADDR
else
  IPADDR=$PUBLIC_IPv4
fi

echo Installing curl etc.
apt update
apt upgrade -y
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
update-grub || true
echo ====> Installing dashboard
install_dashboard

kubectl get pods --all-namespaces

echo "debugging: kubectl describe po -n kube-system"
echo "kubectl proxy -p 8080 --accept-hosts='^*\$' --address="$IPADDR
#https://kubernetes.io/docs/tasks/access-application-cluster/web-ui-dashboard/#master-server
echo "http://$IPADDR:8080/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/"

