$url = "https://github.com/jdx/mise/releases/download/v2024.10.7/mise-v2024.10.7-windows-x64.zip"
$zipFilePath = "$env:TEMP\mise.zip"
$extractPath = "$env:TEMP\mise"
$targetFolder = "$env:USERPROFILE\bin"
$exeToMove = "$extractPath\bin\mise.exe"

# Create the bin directory if it doesn't exist
if (-not (Test-Path -Path $targetFolder)) {
    New-Item -ItemType Directory -Path $targetFolder
}

# Download the ZIP file
Invoke-WebRequest -Uri $url -OutFile $zipFilePath

# Extract the contents of the ZIP file
Expand-Archive -Path $zipFilePath -DestinationPath $extractPath

# Move mise.exe to the bin directory
if (-not (Test-Path -Path $exeToMove)) {
    Move-Item -Path $exeToMove -Destination $targetFolder
}

# Clean up
Remove-Item -Path $zipFilePath -Force
Remove-Item -Path $extractPath -Recurse -Force
