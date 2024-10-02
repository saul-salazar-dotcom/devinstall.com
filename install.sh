#!/bin/sh
# Usage
# curl -fsSL https://raw.githubusercontent.com/saul-salazar-dotcom/devinstall.com/master/install.sh | sh

# Install dependencies (upt and mise)
curl -fsSL https://raw.githubusercontent.com/sigoden/upt/main/install.sh | sh -s -- --to /usr/local/bin
curl -fsSL https://mise.run | sh

# List of packages, tools and extensions
packages="jq,git,make,gcc,pip,zoxide,fzf,zsh,xclip,starship"
tools="eza,zellij,mani,htop,ctop,yq"
extensions="eamodio.gitlens,mhutchie.git-graph,esbenp.prettier-vscode,bungcip.better-toml,mechatroner.rainbow-csv,mikestead.dotenv,EditorConfig.EditorConfig,sketchbuch.vsc-workspace-sidebar,wayou.vscode-todo-highlight,oderwat.indent-rainbow"

# Check and append PACKAGES environment variable
if [ -n "$PACKAGES" ]; then
    packages="$packages,$PACKAGES"
fi

# Install packages
echo "$packages" | tr ',' '\n' | while read -r package; do
    if ! command -v "$package" > /dev/null; then
        sudo upt install "$package" -y
    fi
done
echo "✅ Install completed: Packages ($packages)"

# Check and append TOOLS environment variable
if [ -n "$TOOLS" ]; then
    tools="$tools,$TOOLS"
fi

# Install tools
echo "$tools" | tr ',' '\n' | while read -r tool; do
    mise use -g "$tool"
done
echo "✅ Install completed: Developer Tools ($tools)"

# Check and append EXTENSIONS environment variable
if [ -n "$EXTENSIONS" ]; then
    extensions="$extensions,$EXTENSIONS"
fi

# Install extensions
echo "$extensions" | tr ',' '\n' | while read -r extension; do
    code --install-extension "$extension"
done
echo "✅ Install completed: Editor Extensions ($extensions)"

echo "✨🥳🎉 Congratulations, all done! 🌟°🥂⋆.ೃ🍾࿔*:･"
