# devinstall.com

This repository aims to resolve how to setup a developer machine across multiple OS of Linux, Windows and Mac.

## 🔥 Quick Start
```sh
curl -fsSL https://raw.githubusercontent.com/saul-salazar-dotcom/devinstall.com/master/install.sh | sh
```

## 🚀 Features
- EASY: copy & paste one line
- KISS: script file of 100 lines
- Cross Platform Compatibility powered by [UPT](https://github.com/sigoden/upt)
- Tools Versions Management powered by [mise](https://github.com/jdx/mise)
- Text editor powered by [Visual Studio Code](https://code.visualstudio.com/)
- Works great with multiple Linux OS and MacOS. Windows is limited.

## 📝 Customization

You can use environment variables to extend the functionality:

```sh
export PACKAGES="docker"
export TOOLS="node,go"
export EXTENSIONS="vscodevim.vim,ms-kubernetes-tools.vscode-kubernetes-tools"
curl -fsSL https://raw.githubusercontent.com/saul-salazar-dotcom/devinstall.com/master/install.sh | sh
```
