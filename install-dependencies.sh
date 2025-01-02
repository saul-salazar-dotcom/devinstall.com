#!/bin/sh
# Usage
# curl -fsSL https://raw.githubusercontent.com/saul-salazar-dotcom/devinstall.com/master/install-dependencies.sh | sh
# wget -qO- https://raw.githubusercontent.com/saul-salazar-dotcom/devinstall.com/master/install-dependencies.sh | sh

# Function to check if a package is installed
check_package_installed() {
    packageName=$1
    command -v $packageName > /dev/null 2>&1
}

install_package() {
    packageName=$1
    echo "$packageName is not installed. Attempting to install using a package manager..."
    # Linux
    if command -v apk > /dev/null 2>&1; then
        sudo apk add $packageName
    elif command -v apt-get > /dev/null 2>&1; then
        sudo apt-get update && sudo apt-get install -y $packageName
    elif command -v dnf > /dev/null 2>&1; then
        sudo dnf install -y $packageName
    elif command -v pacman > /dev/null 2>&1; then
        sudo pacman -S $packageName
    elif command -v zypper > /dev/null 2>&1; then
        sudo zypper install -y $packageName
    elif command -v cards > /dev/null 2>&1; then
        sudo cards install $packageName
    elif command -v emerge > /dev/null 2>&1; then
        sudo emerge $packageName
    # Apple
    elif command -v brew > /dev/null 2>&1; then
        sudo brew install $packageName
    elif command -v port > /dev/null 2>&1; then
        sudo port install $packageName
    elif command -v fink > /dev/null 2>&1; then
        sudo fink install $packageName
    else
        echo "ERROR: Unsupported package manager. Please install $packageName manually and run the script again."
        exit 1
    fi
}

install_process() {
    packageName=$1
    if check_package_installed $packageName; then
        echo "$packageName is already installed."
    else
        install_package $packageName
        # Check if package is installed after installation
        if check_package_installed $packageName; then
            echo "$packageName has been installed."
        fi
    fi
}

install_process curl

# The following code fixes the error "package code not found"

# Read OS information
. /etc/os-release

# Determine the package manager and install VS Code dependencies accordingly
if [[ "$ID" == "ubuntu" || "$ID" == "debian" ]]; then
    sudo apt-get install wget gpg
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
    sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
    echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" |sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
    rm -f packages.microsoft.gpg
    sudo apt update
elif [[ "$ID" == "fedora" || "$ID" == "centos" || "$ID" == "rhel" ]]; then
    sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
    echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null
    dnf check-update
fi
