#!/bin/bash

# STATUS: WIP, does not work!

# based on
# https://medium.com/@smijar/installing-kubernetes-all-in-one-on-a-low-resource-vps-1c89dd5f0096
# https://hostadvice.com/how-to/how-to-set-up-kubernetes-in-ubuntu/
# https://ninetaillabs.com/setting-up-a-single-node-kubernetes-cluster/

function_for_safe_piping() {
echo Create single instance k8s master and node

[[ $USER != "root" ]] && echo Please run as root && exit 1

ip a
read -p "Please provide the (public) IP of this machine, on which you'll connect to webui/API-endpoint:" IPADDR

echo => Installing k8s deps
swapoff -a
apt update
#apt dist-upgrade -y
apt -y install \
  apt-transport-https \
  ca-certificates \
  software-properties-common \
  curl

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository "deb https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") $(lsb_release -cs) stable"

curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
add-apt-repository "deb https://apt.kubernetes.io/ kubernetes-$(lsb_release -cs) main"

apt update
apt install -y \
  docker-ce \
  kubelet \
  kubeadm \
  kubernetes-cni

update-grub || true

echo ==> Init master
echo y|kubeadm reset
#https://stackoverflow.com/questions/44305615/pods-are-not-starting-networkplugin-cni-failed-to-set-up-pod
kubeadm init --pod-network-cidr=10.224.0.0/16 --apiserver-advertise-address=$IPADDR

mkdir -p $HOME/.kube 
cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config

#https://github.com/kubernetes/kubernetes/issues/48378
export KUBECONFIG=/etc/kubernetes/kubelet.conf

echo ===> Deploying pod network
#kubectl apply -f https://docs.projectcalico.org/v3.1/getting-started/kubernetes/installation/hosted/rbac-kdd.yaml
#kubectl apply -f https://docs.projectcalico.org/v3.1/getting-started/kubernetes/installation/hosted/kubernetes-datastore/calico-networking/1.7/calico.yaml

#kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/k8s-manifests/kube-flannel-rbac.yml
#kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

echo "net.bridge.bridge-nf-call-iptables=1" >> /etc/sysctl.conf
sysctl -p
kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"

echo TODO until here ...
watch kubectl get pods --all-namespaces


echo ====> Installing dashboard
kubectl taint nodes --all node-role.kubernetes.io/master-
kubectl create -f https://raw.githubusercontent.com/kubernetes/dashboard/master/src/deploy/recommended/kubernetes-dashboard.yaml

cat <<EOF> /tmp/dashboard-admin.yml
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
kubectl create -f /tmp/dashboard-admin.yml

cat <<EOF
kubectl describe po -n kube-system
kubectl get pods --all-namespaces
EOF

}
function_for_safe_piping
