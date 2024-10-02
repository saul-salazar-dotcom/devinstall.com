#!/bin/sh
# Usage
# curl -fsSL https://raw.githubusercontent.com/saul-salazar-dotcom/devinstall.com/master/install.sh | sh

# Install dependencies (upt and mise)
if command -v curl > /dev/null; then
    curl -fsSL https://raw.githubusercontent.com/sigoden/upt/main/install.sh | sudo sh -s -- --to /usr/local/bin
    curl -fsSL https://mise.run | sh
elif command -v wget > /dev/null; then
    wget -qO- https://raw.githubusercontent.com/sigoden/upt/main/install.sh | sudo sh -s -- --to /usr/local/bin
    wget -qO- https://mise.run | sh
fi
mise="$HOME/.local/bin/mise"
upt="/usr/local/bin/upt"

# List of packages, tools and extensions
packages="jq,git,make,gcc,vscode,code,pip,zoxide,fzf,zsh,xclip,htop,ntop"
tools="eza,zellij,mani,ctop,yq,starship"
extensions="eamodio.gitlens,mhutchie.git-graph,esbenp.prettier-vscode,bungcip.better-toml,mechatroner.rainbow-csv,mikestead.dotenv,EditorConfig.EditorConfig,sketchbuch.vsc-workspace-sidebar,wayou.vscode-todo-highlight,oderwat.indent-rainbow"

# Check and append PACKAGES environment variable
if [ -n "$PACKAGES" ]; then
    packages="$packages,$PACKAGES"
fi

# Install packages
echo "$packages" | tr ',' '\n' | while read -r package; do
    if ! command -v "$package" > /dev/null; then
        sudo $upt install "$package" -y
    fi
done
echo "✅ Install completed: Packages ($packages)"

# Check and append TOOLS environment variable
if [ -n "$TOOLS" ]; then
    tools="$tools,$TOOLS"
fi

# Install tools
echo "$tools" | tr ',' '\n' | while read -r tool; do
    $mise use -g "$tool" -y
done
echo "✅ Install completed: Developer Tools ($tools)"

# Check and append EXTENSIONS environment variable
if [ -n "$EXTENSIONS" ]; then
    extensions="$extensions,$EXTENSIONS"
fi

# Install editor (fix for linux systems like Debian and Ubuntu)
if ! command -v "code" > /dev/null; then
    UPT_TOOL=snap $upt install code -y
fi

# Install extensions
if command -v "code" > /dev/null; then
    echo "$extensions" | tr ',' '\n' | while read -r extension; do
        code --install-extension "$extension"
    done
    echo "✅ Install completed: Editor Extensions ($extensions)"
fi

current_shell=$(basename "$SHELL")
export PATH="$HOME/.local/share/mise/shims:$PATH"
case "$current_shell" in
    bash)
        echo 'export PATH="$HOME/.local/share/mise/shims:$PATH"' >> ~/.bashrc
        echo 'eval "$(~/.local/bin/mise activate bash)"' >> ~/.bashrc
        echo 'eval "$(starship init bash)"' >> ~/.bashrc
        eval "$(~/.local/bin/mise activate bash)"
        eval "$(starship init bash)"
        ;;
    zsh)
        echo 'export PATH="$HOME/.local/share/mise/shims:$PATH"' >> ~/.zshrc
        echo 'eval "$(~/.local/bin/mise activate zsh)"' >> ~/.zshrc
        echo 'eval "$(starship init zsh)"' >> ~/.zshrc
        eval "$(~/.local/bin/mise activate zsh)"
        eval "$(starship init zsh)"
        ;;
    fish)
        echo '~/.local/bin/mise activate fish | source' >> ~/.config/fish/config.fish
        echo 'starship init fish | source' >> ~/.config/fish/config.fish
        eval "$(~/.local/bin/mise activate fish)"
        fish_add_path ~/.local/share/mise/shims
        ~/.local/bin/mise activate fish | source
        starship init fish | source
        ;;
    *)
        echo "Unknown shell: $current_shell, please open an issue https://github.com/saul-salazar-dotcom/devinstall.com/issues/new"
        ;;
esac

echo "✨🥳🎉 Congratulations, all done! 🌟°🥂⋆.ೃ🍾࿔*:･"
