#!/bin/sh
# Usage
# curl -fsSL https://raw.githubusercontent.com/saul-salazar-dotcom/devinstall.com/master/install.sh | sh
# wget -qO- https://raw.githubusercontent.com/saul-salazar-dotcom/devinstall.com/master/install.sh | sh

# exit on error
set -o errexit

# Install dependencies
wget -qO- https://raw.githubusercontent.com/saul-salazar-dotcom/devinstall.com/master/install-dependencies.sh | sh
if ! command -v upt > /dev/null; then
    curl -fsSL https://raw.githubusercontent.com/sigoden/upt/main/install.sh | sudo sh -s -- --to /usr/local/bin > /dev/null
fi
if ! command -v mise > /dev/null; then
    curl -fsSL https://mise.run | sh > /dev/null
fi
mise="$HOME/.local/bin/mise"
upt="/usr/local/bin/upt"

# List of packages, tools and extensions
packages="jq,git,make,gcc,vscode,code,pip,zoxide,zsh,xclip,htop"
tools="node@lts,eza,zellij,mani,ctop,yq,starship,fzf"
extensions="eamodio.gitlens,mhutchie.git-graph,esbenp.prettier-vscode,tamasfe.even-better-toml,mechatroner.rainbow-csv,mikestead.dotenv,EditorConfig.EditorConfig,sketchbuch.vsc-workspace-sidebar,wayou.vscode-todo-highlight,oderwat.indent-rainbow,streetsidesoftware.code-spell-checker,Gruntfuggly.todo-tree,usernamehw.errorlens,MS-vsliveshare.vsliveshare,ritwickdey.LiveServer,wholroyd.jinja,ms-python.python,KevinRose.vsc-python-indent,donjayamanne.python-environment-manager,ms-python.vscode-pylance,njpwerner.autodocstring,VisualStudioExptTeam.vscodeintellicode,christian-kohler.path-intellisense"

# Check and append PACKAGES environment variable
if [ -n "$PACKAGES" ]; then
    packages="$packages,$PACKAGES"
fi

# Install packages
echo "$packages" | tr ',' '\n' | while read -r package; do
    if ! command -v "$package" > /dev/null; then
        sudo $upt install "$package" -y || true
    fi
done

# Check and append TOOLS environment variable
if [ -n "$TOOLS" ]; then
    tools="$tools,$TOOLS"
fi

# Install tools
echo "$tools" | tr ',' '\n' | while read -r tool; do
    $mise use -g "$tool" -y
done

# Check and append EXTENSIONS environment variable
if [ -n "$EXTENSIONS" ]; then
    extensions="$extensions,$EXTENSIONS"
fi

# Install extensions
if command -v "code" > /dev/null; then
    echo "$extensions" | tr ',' '\n' | while read -r extension; do
        code --install-extension "$extension"
    done
fi

if test -f $HOME/.bashrc;
then
    echo 'eval "$(~/.local/bin/mise activate bash --shims)"' >> ~/.bashrc
    echo 'eval "$(~/.local/bin/mise activate bash)"' >> ~/.bashrc
    echo 'eval "$(mani completion bash)"' >> ~/.bashrc
    echo 'eval "$(fzf --bash)"' >> ~/.bashrc
    echo 'eval "$(zoxide init bash)"' >> ~/.bashrc
    echo 'eval "$(starship init bash)"' >> ~/.bashrc
fi

if test -f $HOME/.zshrc;
then
    echo 'eval "$(~/.local/bin/mise activate zsh --shims)"' >> ~/.zshrc
    echo 'eval "$(~/.local/bin/mise activate zsh)"' >> ~/.zshrc
    echo 'eval "$(mani completion zsh)"' >> ~/.zshrc
    echo 'source <(fzf --zsh)"' >> ~/.zshrc
    echo 'eval "$(zoxide init zsh)"' >> ~/.zshrc
    echo 'eval "$(starship init zsh)"' >> ~/.zshrc
fi

echo "✅ Install completed: System Packages"
echo "✅ Install completed: Developer Tools"
echo "✅ Install completed: Editor Extensions"
echo "✨🥳🎉 Congratulations, all done! Open a new terminal! 🌟°🥂⋆.ೃ🍾࿔*:･"
