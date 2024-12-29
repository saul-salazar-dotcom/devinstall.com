$apiUrl = "https://api.github.com/repos/sigoden/upt/releases/latest"
$response = Invoke-RestMethod -Uri $apiUrl -Headers @{ "User-Agent" = "PowerShell" }
$latestVersion = $response.tag_name
$url = "https://github.com/sigoden/upt/releases/download/$latestVersion/upt-$latestVersion-x86_64-pc-windows-msvc.zip"
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
