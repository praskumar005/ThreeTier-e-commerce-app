#!/bin/bash
sudo apt-get update -y
sudo apt-get install snapd -y

# Install AWS CLI
sudo snap install aws-cli --classic

# Install Helm
sudo snap install helm --classic

# Install Kubectl
sudo snap install kubectl --classic

#Install EKSCTL

#!/bin/bash

set -e

echo "Installing eksctl..."

# Install required packages
apt-get update -y
apt-get install -y curl tar gzip

# Detect architecture
case "$(uname -m)" in
    x86_64)
        ARCH="amd64"
        ;;
    aarch64)
        ARCH="arm64"
        ;;
    *)
        echo "Unsupported architecture: $(uname -m)"
        exit 1
        ;;
esac

PLATFORM="$(uname -s)_${ARCH}"

echo "Detected platform: ${PLATFORM}"

# Download eksctl
curl -sLO "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_${PLATFORM}.tar.gz"

# Extract
tar -xzf "eksctl_${PLATFORM}.tar.gz" -C /tmp

# Install
sudo mv /tmp/eksctl /usr/local/bin/eksctl

# Cleanup
rm -f "eksctl_${PLATFORM}.tar.gz"

# Verify
echo "eksctl installation completed:"
/usr/local/bin/eksctl version
