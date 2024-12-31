#/bin/bash
## DEDECTORS 
git-pull() {
    mkdir /tmp/bsd
    cd /tmp/bsd
    curl -O /tmp/bsd/ 
}
docker-pull() {
    docker pull itzg/minecraft-bedrock-server
    mkdir /etc/bsd/
    mv /tmp/bsd/* /etc/bsd/
    mv /etc/bsd/bsd /usr/local/bin/
    echo "INSTALL COMPLETE!"
    ui
}
docker-detect() {
  DOCKER_CMD=$(which docker)
   if [[ ! -z $DOCKER_CMD ]]; then
    echo "docker is installed contining.."

 else
   echo "docker not found installing ..."
   set -ex

OS=$(uname -s | tr A-Z a-z)

case $OS in
  linux)
    source /etc/os-release
    case $ID in
      debian|ubuntu|mint)
           apt-get update
           apt-get install ca-certificates curl
           install -m 0755 -d /etc/apt/keyrings
           curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
           chmod a+r /etc/apt/keyrings/docker.asc

        # Add the repository to Apt sources:
        echo \
            "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
            $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
             tee /etc/apt/sources.list.d/docker.list > /dev/null
               apt-get update
               apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
               docker run hello-world
        ;;

      fedora|rhel|centos)
        yum update
        dnf -y install dnf-plugins-core
        dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
        dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
           systemctl enable --now docker
           systemctl enable --now docker
        ;;
  *)
    echo -n "unsupported OS please install docker on your own to continue!"
    ;;
esac
 fi

}