Setup a developer machine in a single command (multiple OS). Read the [source code](https://github.com/saul-salazar-dotcom/devinstall.com).

You will get a [Starship](https://starship.rs/) terminal, [Visual Studio Code](https://code.visualstudio.com/) with extensions and [a lot more packages and tools](#defaults) which you can further [customize](#customization)
![starship example](https://starship.rs/presets/img/pastel-powerline.png)

## 🔥 Quick Start
```sh
curl -fsSL https://raw.githubusercontent.com/saul-salazar-dotcom/devinstall.com/master/install.sh | sh
```

## 📝 Customization

You can use environment variables to extend the functionality:

```sh
export PACKAGES="docker"
export TOOLS="node,go"
export EXTENSIONS="vscodevim.vim"
curl -fsSL https://raw.githubusercontent.com/saul-salazar-dotcom/devinstall.com/master/install.sh | sh
```

## 🚀 Features
- EASY: copy & paste one line
- KISS: script file of 100 lines
- Cross Platform Wrapper powered by [UPT](https://github.com/sigoden/upt)
- Tools Versions Manager powered by [mise](https://github.com/jdx/mise)
- Text Editor powered by [Visual Studio Code](https://code.visualstudio.com/)
- Works great with multiple Linux OS and MacOS. Windows is limited.

## 📦 Requirements

The only dependency is `curl` for Linux and MacOS. On Windows you may need to install Git Bash.

```sh
brew install curl # MacOS
apt install curl # Debian and Ubuntu
yum install curl # Redhat and CentOS
dnf install curl # Fedora
nix-env -i curl # NixOS
pacman -S curl # Arch Linux
zypper install curl # SUSE and OpenSUSE
emerge net-misc/curl # Gentoo
xbps-install curl # Void Linux
```

## 🔤 Defaults

- Packages
    - [jq](https://jqlang.github.io/jq/) (`json` CLI processor)
    - [git](https://git-scm.com/) (version control)
    - [gcc](https://gcc.gnu.org/) (gnu compilers)
    - [zsh](https://www.zsh.org/) (`bash` shell alternative)
    - [pip](https://pip.pypa.io/en/stable/) (python package manager)
    - [fzf](https://github.com/junegunn/fzf) (fuzzy finder for CLI)
    - [make](https://www.gnu.org/software/make/) (build tool)
    - [code](https://code.visualstudio.com/) (text editor)
    - [xclip](https://github.com/astrand/xclip) (terminal to clipboard)
    - [zoxide](https://zoxide.dev/) (`cd` command alternative)
    - [starship](https://starship.rs/) (terminal prompt)
- Tools
    - [eza](https://eza.rocks/) (`ls` command alternative)
    - [mani](https://manicli.com/) (multiple git manager)
    - [htop](https://htop.dev/) (`top` command alternative)
    - [ctop](https://ctop.sh/) (`top` for containers)
    - [zellij](https://zellij.dev/) (`tmux` alternative)
- Extensions
    - [Git Lens](https://marketplace.visualstudio.com/items?itemName=eamodio.gitlens)
    - [Git Graph](https://marketplace.visualstudio.com/items?itemName=mhutchie.git-graph)
    - [Prettier](https://marketplace.visualstudio.com/items?itemName=esbenp.prettier-vscode)
    - [Better TOML](https://marketplace.visualstudio.com/items?itemName=bungcip.better-toml)
    - [Rainbow CSV](https://marketplace.visualstudio.com/items?itemName=mechatroner.rainbow-csv)
    - [DotEnv](https://marketplace.visualstudio.com/items?itemName=mikestead.dotenv)
    - [EditorConfig](https://marketplace.visualstudio.com/items?itemName=EditorConfig.EditorConfig)
    - [Workspace Sidebar](https://marketplace.visualstudio.com/items?itemName=sketchbuch.vsc-workspace-sidebar)
    - [TODO Highlight](https://marketplace.visualstudio.com/items?itemName=wayou.vscode-todo-highlight)
    - [Indent Rainbow](https://marketplace.visualstudio.com/items?itemName=oderwat.indent-rainbow)

## 💡 FAQ

### Why some things are installed using UPT and others using mise?
Because some things are not compatible via a native package manager and we have to use mise to download directly from GitHub releases.
