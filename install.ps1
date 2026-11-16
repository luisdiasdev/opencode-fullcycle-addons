# Install the Full Cycle OpenCode Pack globally on Windows.
#
# Usage:
#   .\install.ps1                  # copy files
#   .\install.ps1 -Symlink         # symlink files (keeps repo live)
#   $env:OPENCODE_CONFIG_DIR="C:\Custom"; .\install.ps1

[CmdletBinding()]
param(
    [switch]$Symlink,
    [switch]$Help
)

if ($Help) {
    Write-Host "Usage: .\install.ps1 [-Symlink]"
    Write-Host "  -Symlink  Create symbolic links instead of copying files."
    Write-Host "  Set `$env:OPENCODE_CONFIG_DIR` to override the target config directory."
    exit 0
}

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$SourceAgentsDir = Join-Path $ScriptDir ".opencode\agents"
$SourceCommandsDir = Join-Path $ScriptDir ".opencode\commands"

# Determine OpenCode config directory
if ($env:OPENCODE_CONFIG_DIR) {
    $ConfigDir = $env:OPENCODE_CONFIG_DIR
} else {
    # OpenCode uses ~/.config/opencode on Windows as well
    $ConfigDir = Join-Path $env:USERPROFILE ".config\opencode"
}

$TargetAgentsDir = Join-Path $ConfigDir "agents"
$TargetCommandsDir = Join-Path $ConfigDir "commands"

New-Item -ItemType Directory -Force -Path $TargetAgentsDir | Out-Null
New-Item -ItemType Directory -Force -Path $TargetCommandsDir | Out-Null

function Install-File {
    param(
        [string]$SourcePath,
        [string]$TargetDir
    )

    $FileName = Split-Path -Leaf $SourcePath
    $TargetPath = Join-Path $TargetDir $FileName

    if ((Test-Path $TargetPath) -and -not (Test-Path $TargetPath -PathType SymbolicLink)) {
        $Timestamp = Get-Date -Format "yyyyMMddHHmmss"
        $BackupPath = "${TargetPath}.backup.${Timestamp}"
        Copy-Item -Path $TargetPath -Destination $BackupPath -Force
        Write-Host "  Backed up existing $FileName -> $BackupPath"
    }

    if ($Symlink) {
        if (Test-Path $TargetPath) {
            Remove-Item $TargetPath -Force -Recurse -ErrorAction SilentlyContinue
        }
        New-Item -ItemType SymbolicLink -Path $TargetPath -Target $SourcePath -Force | Out-Null
    } else {
        Copy-Item -Path $SourcePath -Destination $TargetPath -Force
    }
}

# Warn about symlink requirements on Windows
if ($Symlink) {
    try {
        $testLink = Join-Path $env:TEMP "opencode-pack-symlink-test-$(Get-Random)"
        $testTarget = Join-Path $env:TEMP "opencode-pack-symlink-target-$(Get-Random)"
        New-Item -ItemType SymbolicLink -Path $testLink -Target $testTarget -ErrorAction Stop | Out-Null
        Remove-Item $testLink -Force -ErrorAction SilentlyContinue
    } catch {
        Write-Warning "Symbolic links require Administrator rights or Developer Mode on Windows."
        Write-Warning "Falling back to copy mode. To use symlinks, run PowerShell as Administrator or enable Developer Mode."
        $Symlink = $false
    }
}

Write-Host "Installing Full Cycle OpenCode Pack..."
Write-Host "  Source: $SourceAgentsDir"
Write-Host "  Target: $ConfigDir"
Write-Host "  Mode:   $(if ($Symlink) { 'symlink' } else { 'copy' })"
Write-Host

Write-Host "Installing agents into $TargetAgentsDir`:"
Get-ChildItem -Path $SourceAgentsDir -Filter "*.md" | ForEach-Object {
    Install-File -SourcePath $_.FullName -TargetDir $TargetAgentsDir
    Write-Host "  + $($_.Name)"
}

Write-Host
Write-Host "Installing commands into $TargetCommandsDir`:"
Get-ChildItem -Path $SourceCommandsDir -Filter "*.md" | ForEach-Object {
    Install-File -SourcePath $_.FullName -TargetDir $TargetCommandsDir
    Write-Host "  + $($_.Name)"
}

Write-Host
Write-Host "Installation complete."
Write-Host "Restart OpenCode to load the new agents and commands."
