# devinstall.com

This repository aims to resolve how to setup a developer machine across multiple OS of Linux, Mac and Windows.

## 🔥 Quick Start

Mac and Linux-based distros:
```sh
curl -fsSL https://raw.githubusercontent.com/saul-salazar-dotcom/devinstall.com/master/install.sh | sh
```

On Windows, please open a PowerShell terminal **as an Administrator** and copy & paste the following command:
```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/saul-salazar-dotcom/devinstall.com/master/install.ps1'))
```

## 🚀 Features
- EASY: copy & paste one line
- KISS: script file of 100 lines
- Cross Platform Compatibility powered by [UPT](https://github.com/sigoden/upt)
- Tools Versions Management powered by [mise](https://github.com/jdx/mise)
- Text editor powered by [Visual Studio Code](https://code.visualstudio.com/)
- Works great with multiple Linux OS, MacOS and Windows.

## 📝 Customization

You can use environment variables to extend the functionality:

```sh
export PACKAGES="docker"
export TOOLS="java,go"
export EXTENSIONS="vscodevim.vim,ms-kubernetes-tools.vscode-kubernetes-tools"
curl -fsSL https://raw.githubusercontent.com/saul-salazar-dotcom/devinstall.com/master/install.sh | sh
```

```powershell
$env:PACKAGES = "docker-desktop"
$env:TOOLS = "java,go"
$env:TOOLS = "vscodevim.vim,ms-kubernetes-tools.vscode-kubernetes-tools"

Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/saul-salazar-dotcom/devinstall.com/master/install.ps1'))
```
