$url = "https://github.com/sigoden/upt/releases/download/v0.8.0/upt-v0.8.0-x86_64-pc-windows-msvc.zip"
$zipFilePath = "$env:TEMP\upt.zip"
$targetFolder = "$env:USERPROFILE\bin"

# Create the bin directory if it doesn't exist
if (-not (Test-Path -Path $targetFolder)) {
    New-Item -ItemType Directory -Path $targetFolder
}

# Download the ZIP file
Invoke-WebRequest -Uri $url -OutFile $zipFilePath

# Extract the contents of the ZIP file
Expand-Archive -Path $zipFilePath -DestinationPath $targetFolder

# Clean up
Remove-Item -Path $zipFilePath -Force
