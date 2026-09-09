# Instalador automático de Snippets para C en VS Code / VSCodium (Windows PowerShell)

$ErrorActionPreference = "Stop"

$CodeSnippetsPath = "$env:APPDATA\Code\User\snippets"
$CodiumSnippetsPath = "$env:APPDATA\VSCodium\User\snippets"
$InsidersSnippetsPath = "$env:APPDATA\Code - Insiders\User\snippets"

$Paths = @($CodeSnippetsPath, $CodiumSnippetsPath, $InsidersSnippetsPath)
$RawUrl = "https://raw.githubusercontent.com/edelacruzcr/CCompleter/main/c.json"

$Installed = $false

foreach ($Path in $Paths) {
    $Parent = Split-Path -Path $Path -Parent
    if (Test-Path $Parent) {
        if (-not (Test-Path $Path)) {
            New-Item -ItemType Directory -Path $Path -Force | Out-Null
        }
        
        $OutputFile = Join-Path -Path $Path -ChildPath "c.json"
        
        if (Test-Path ".\c.json") {
            Copy-Item -Path ".\c.json" -Destination $OutputFile -Force
        } else {
            Invoke-WebRequest -Uri $RawUrl -OutFile $OutputFile
        }
        Write-Host "Instalado exitosamente en: $OutputFile"
        $Installed = true
    }
}

if (-not $Installed) {
    if (-not (Test-Path $CodeSnippetsPath)) {
        New-Item -ItemType Directory -Path $CodeSnippetsPath -Force | Out-Null
    }
    $OutputFile = Join-Path -Path $CodeSnippetsPath -ChildPath "c.json"
    Invoke-WebRequest -Uri $RawUrl -OutFile $OutputFile
    Write-Host "Instalado en: $OutputFile"
}

Write-Host "`nInstalación finalizada con éxito."
Write-Host "Abre cualquier archivo .c en VS Code y escribe 'main' o 'inc_todos'."
