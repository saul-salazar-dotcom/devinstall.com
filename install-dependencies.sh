#!/bin/sh
# Usage
# curl -fsSL https://raw.githubusercontent.com/saul-salazar-dotcom/devinstall.com/master/install-dependencies.sh | sh
# wget -qO- https://raw.githubusercontent.com/saul-salazar-dotcom/devinstall.com/master/install-dependencies.sh | sh

# Function to check if a package is installed
check_package_installed() {
    packageName=$1
    command -v $packageName >/dev/null 2>&1
}

install_package() {
    packageName=$1
    echo "$packageName is not installed. Attempting to install using a package manager..."
    # Linux
    if command -v apk >/dev/null 2>&1; then
        sudo apk add $packageName
    if command -v apt-get >/dev/null 2>&1; then
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
        exit(1)
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
