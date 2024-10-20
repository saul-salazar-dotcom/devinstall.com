# Check if running as Administrator
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "Please run this script as an Administrator."
    exit
}

# Create target folder if it doesn't exist
$targetFolder = "$env:USERPROFILE\bin"
if (-not (Test-Path -Path $targetFolder)) {
    New-Item -ItemType Directory -Path $targetFolder
}

# Add the folder to the PATH environment variable
$envPath = [System.Environment]::GetEnvironmentVariable("Path", "User")
if (-not $envPath.Split(';') -contains $targetFolder) {
    $newPath = "$envPath;$targetFolder"
    [System.Environment]::SetEnvironmentVariable("Path", $newPath, "User")
}

# execute installation scripts
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/saul-salazar-dotcom/devinstall.com/windows/install-upt.ps1'))
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/saul-salazar-dotcom/devinstall.com/windows/install-mise.ps1'))

$mise = "$env:USERPROFILE\bin\mise.exe"
$upt = "$env:USERPROFILE\bin\upt.exe"

# List of packages, tools, and extensions
$packages = "jq,git,make,gcc,vscode,pip,zoxide,fzf,zsh,xclip,htop,ntop"
$tools = "eza,zellij,mani,ctop,yq,starship"
$extensions = "eamodio.gitlens,mhutchie.git-graph,esbenp.prettier-vscode,tamasfe.even-better-toml,mechatroner.rainbow-csv,mikestead.dotenv,EditorConfig.EditorConfig,sketchbuch.vsc-workspace-sidebar,wayou.vscode-todo-highlight,oderwat.indent-rainbow"

# Check and append PACKAGES environment variable
if ($env:PACKAGES) {
    $packages += ",$env:PACKAGES"
}

# Install packages
$packages -split ',' | ForEach-Object {
    if (-not (Get-Command $_ -ErrorAction SilentlyContinue)) {
        & $upt install $_ -y
    }
}

# Check and append TOOLS environment variable
if ($env:TOOLS) {
    $tools += ",$env:TOOLS"
}

# Install tools
$tools -split ',' | ForEach-Object {
    & $mise use -g $_ -y
}

# Check and append EXTENSIONS environment variable
if ($env:EXTENSIONS) {
    $extensions += ",$env:EXTENSIONS"
}

# Install editor (fix for Linux systems like Debian and Ubuntu)
if (-not (Get-Command code -ErrorAction SilentlyContinue)) {
    & $upt install code -y
}

# Install extensions
if (Get-Command code -ErrorAction SilentlyContinue) {
    $extensions -split ',' | ForEach-Object {
        code --install-extension $_
    }
}
