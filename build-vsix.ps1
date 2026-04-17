[CmdletBinding()]
param(
    [string]$ExtensionDir = "",
    [string]$OutFile = ""
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

if ([string]::IsNullOrWhiteSpace($ExtensionDir)) {
    $ExtensionDir = Join-Path $PSScriptRoot "."
}

if ([string]::IsNullOrWhiteSpace($OutFile)) {
    $OutFile = Join-Path $PSScriptRoot ".\vscode-xcode-dark-theme.vsix"
}

# Read extension metadata from package.json to keep manifest fields consistent.
$packagePath = Join-Path $ExtensionDir "package.json"
$package = Get-Content -Encoding UTF8 -LiteralPath $packagePath | ConvertFrom-Json

$publisher = [string]$package.publisher
$name = [string]$package.name
$displayName = [string]$package.displayName
$description = [string]$package.description
$version = [string]$package.version
$engine = [string]$package.engines.vscode

$stageDir = Join-Path $PSScriptRoot ".\.vsix-build\vscode-xcode-dark-theme"
$extensionStageDir = Join-Path $stageDir "extension"
$zipPath = [System.IO.Path]::ChangeExtension($OutFile, ".zip")

if (Test-Path -LiteralPath $stageDir) {
    Remove-Item -LiteralPath $stageDir -Recurse -Force
}

if (Test-Path -LiteralPath $zipPath) {
    Remove-Item -LiteralPath $zipPath -Force
}

if (Test-Path -LiteralPath $OutFile) {
    Remove-Item -LiteralPath $OutFile -Force
}

New-Item -ItemType Directory -Path $extensionStageDir -Force | Out-Null

# Keep package content deterministic and avoid shipping local build helpers.
$includePaths = @(
    "package.json",
    "README.md",
    "LICENSE",
    "themes",
    "images"
)

foreach ($relativePath in $includePaths) {
    $sourcePath = Join-Path $ExtensionDir $relativePath
    if (Test-Path -LiteralPath $sourcePath) {
        Copy-Item -LiteralPath $sourcePath -Destination $extensionStageDir -Recurse -Force
    }
}

$vsixManifest = @"
<?xml version="1.0" encoding="utf-8"?>
<PackageManifest Version="2.0.0" xmlns="http://schemas.microsoft.com/developer/vsx-schema/2011">
  <Metadata>
    <Identity Language="en-US" Id="$publisher.$name" Version="$version" Publisher="$publisher" />
    <DisplayName>$displayName</DisplayName>
    <Description xml:space="preserve">$description</Description>
    <Tags>theme dark xcode intellij sky</Tags>
    <Categories>Themes</Categories>
    <GalleryFlags>Public</GalleryFlags>
    <Properties>
      <Property Id="Microsoft.VisualStudio.Code.Engine" Value="$engine" />
      <Property Id="Microsoft.VisualStudio.Code.ExtensionKind" Value="ui" />
      <Property Id="Microsoft.VisualStudio.Code.PreRelease" Value="false" />
    </Properties>
  </Metadata>
  <Installation>
    <InstallationTarget Id="Microsoft.VisualStudio.Code" />
  </Installation>
  <Dependencies />
  <Assets>
    <Asset Type="Microsoft.VisualStudio.Code.Manifest" Path="extension/package.json" Addressable="true" />
    <Asset Type="Microsoft.VisualStudio.Services.Content.Details" Path="extension/README.md" Addressable="true" />
    <Asset Type="Microsoft.VisualStudio.Services.Content.License" Path="extension/LICENSE" Addressable="true" />
  </Assets>
</PackageManifest>
"@

$contentTypes = @"
<?xml version="1.0" encoding="utf-8"?>
<Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">
  <Default Extension="json" ContentType="application/json" />
  <Default Extension="vsixmanifest" ContentType="text/xml" />
  <Default Extension="xml" ContentType="text/xml" />
  <Default Extension="md" ContentType="text/markdown" />
  <Default Extension="txt" ContentType="text/plain" />
  <Default Extension="png" ContentType="image/png" />
  <Default Extension="jpg" ContentType="image/jpeg" />
  <Default Extension="jpeg" ContentType="image/jpeg" />
  <Default Extension="gif" ContentType="image/gif" />
  <Default Extension="svg" ContentType="image/svg+xml" />
</Types>
"@

$vsixManifestPath = Join-Path $stageDir "extension.vsixmanifest"
$contentTypesPath = Join-Path $stageDir "[Content_Types].xml"

Set-Content -LiteralPath $vsixManifestPath -Value $vsixManifest -Encoding UTF8
Set-Content -LiteralPath $contentTypesPath -Value $contentTypes -Encoding UTF8

Compress-Archive -Path (Join-Path $stageDir "*") -DestinationPath $zipPath -Force
Move-Item -LiteralPath $zipPath -Destination $OutFile -Force

Write-Output "VSIX created: $OutFile"
