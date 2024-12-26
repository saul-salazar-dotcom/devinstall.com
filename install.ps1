# Check if running as Administrator
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "Please run this script as an Administrator."
    exit
}

# Add the folder to the PATH environment variable
$envPath = [System.Environment]::GetEnvironmentVariable("Path", "Machine")
if (-not $envPath.Split(';') -contains $targetFolder) {
    $newPath = "$envPath;$targetFolder"
    [System.Environment]::SetEnvironmentVariable("Path", $newPath, "Machine")
}

# execute installation scripts conditionally
if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
    Write-Host "Installing choco"
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
    # install Visual C++ Redistributable 2015-2022
    choco install vcredist140 -y
    Write-Host "Finished installing choco (and requirements)"
}

if (-not (Get-Command upt -ErrorAction SilentlyContinue)) {
    Write-Host "Installing upt"
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/saul-salazar-dotcom/devinstall.com/windows/install-upt.ps1'))
    Write-Host "Finished installing upt"
}

if (-not (Get-Command mise -ErrorAction SilentlyContinue)) {
    Write-Host "Installing mise"
    winget install jdx.mise
    Write-Host "Finished installing mise"
}

$mise = "$env:USERPROFILE\bin\mise.exe"
$upt = "$env:USERPROFILE\bin\upt.exe"
$code = "$env:PROGRAMFILES\Microsoft VS Code\bin\code.cmd"

# List of packages, tools, and extensions
$packages = "jq,git,make,vscode,python,zoxide,fzf,bottom,ntop.portable,starship,yq"
$tools = "node@lts"
$extensions = "eamodio.gitlens,mhutchie.git-graph,esbenp.prettier-vscode,tamasfe.even-better-toml,mechatroner.rainbow-csv,mikestead.dotenv,EditorConfig.EditorConfig,sketchbuch.vsc-workspace-sidebar,wayou.vscode-todo-highlight,oderwat.indent-rainbow,ms-vscode-remote.remote-wsl,streetsidesoftware.code-spell-checker,Gruntfuggly.todo-tree,usernamehw.errorlens,MS-vsliveshare.vsliveshare,ritwickdey.LiveServer,wholroyd.jinja,ms-python.python,KevinRose.vsc-python-indent,donjayamanne.python-environment-manager,ms-python.vscode-pylance,njpwerner.autodocstring,VisualStudioExptTeam.vscodeintellicode,christian-kohler.path-intellisense"

# Native Install of tools
winget install eza-community.eza
(Invoke-WebRequest -UseBasicParsing https://github.com/Slackadays/Clipboard/raw/main/install.ps1).Content | powershell

if ($env:PACKAGES) {
    $packages += ",$env:PACKAGES"
}

# Install packages
$packages -split ',' | ForEach-Object {
    if (-not (Get-Command $_ -ErrorAction SilentlyContinue)) {
        & $upt install $_ -y
    }
}

if ($env:TOOLS) {
    $tools += ",$env:TOOLS"
}

# Install tools
$tools -split ',' | ForEach-Object {
    & $mise use -g $_ -y
}

if ($env:EXTENSIONS) {
    $extensions += ",$env:EXTENSIONS"
}

# Install extensions
$extensions -split ',' | ForEach-Object {
    & $code --install-extension $_
}

$filePathRC = "$env:userprofile\.bashrc"
$contentRC = 'eval "$(starship init bash)"'
if (Test-Path $filePathRC) { # Append the content if the file exists
    Add-Content -Path $filePathRC -Value $contentRC
} else { # Create the file and write the content if it does not exist
    Set-Content -Path $filePathRC -Value $contentRC
}

$filePath = "$env:userprofile\.bash_profile"
$content = @'
test -f ~/.profile && . ~/.profile
test -f ~/.bashrc && . ~/.bashrc
'@
if (Test-Path $filePath) {
    Add-Content -Path $filePath -Value $content
} else {
    Set-Content -Path $filePath -Value $content
}

Write-Host "Install completed: System Packages"
Write-Host "Install completed: Developer Tools"
Write-Host "Install completed: Editor Extensions"
Write-Host "Congratulations, all done! Open a new terminal!"
