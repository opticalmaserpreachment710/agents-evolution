# AGENTS.md Installer — Windows (PowerShell)
# Устанавливает AGENTS.md, скиллы, мета-оркестрацию и примеры субагентов
# Совместимость: PowerShell 5.1+ (UTF-8 без BOM, ASCII-safe вывод)

$ErrorActionPreference = "Stop"

# Надёжное определение SCRIPT_DIR (работает в PS 5.1 и PS 7+)
if ($null -ne $MyInvocation.MyCommand.Path -and (Test-Path $MyInvocation.MyCommand.Path)) {
    $SCRIPT_DIR = Split-Path -Parent $MyInvocation.MyCommand.Path
} elseif ($null -ne $PSScriptRoot -and $PSScriptRoot -ne '') {
    $SCRIPT_DIR = $PSScriptRoot
} else {
    $SCRIPT_DIR = (Get-Location).Path
}

# ASCII-safe вывод (PowerShell 5.1 ломает UTF-8 без BOM)
Write-Host ""
Write-Host "+==================================================+" -ForegroundColor Cyan
Write-Host "|     AGENTS.md Installer v2.0                     |" -ForegroundColor Cyan
Write-Host "|     Windows (PowerShell) - s subagentami         |" -ForegroundColor Cyan
Write-Host "+==================================================+" -ForegroundColor Cyan
Write-Host ""

# Определяем директорию пользователя
$HOME_DIR = $env:USERPROFILE

Write-Host "[~] Ustanovka iz: $SCRIPT_DIR" -ForegroundColor Yellow
Write-Host "[~] Domashnyaya direktoriya: $HOME_DIR" -ForegroundColor Yellow
Write-Host ""

# Проверка существования AGENTS.md
if (-not (Test-Path (Join-Path $SCRIPT_DIR "AGENTS.md"))) {
    Write-Host "[X] AGENTS.md ne nayden v $SCRIPT_DIR" -ForegroundColor Red
    Write-Host "   Zapustite skript iz direktorii repozitoriya" -ForegroundColor Red
    exit 1
}

Write-Host "[>] Nachalo ustanovki..." -ForegroundColor Green
Write-Host ""

# 1. Копируем AGENTS.md
Write-Host "[1] Kopiruyu AGENTS.md -> $HOME_DIR\" -ForegroundColor Yellow
Copy-Item (Join-Path $SCRIPT_DIR "AGENTS.md") (Join-Path $HOME_DIR "AGENTS.md") -Force
Write-Host "    [OK] AGENTS.md ustanovlen" -ForegroundColor Green

# 2. Создаём директории
Write-Host "[2] Sozdayu .agents\skills\" -ForegroundColor Yellow
$skillsDir = Join-Path $HOME_DIR ".agents\skills"
New-Item -ItemType Directory -Path $skillsDir -Force | Out-Null

Write-Host "    Sozdayu .agents\ExampleSubagents\" -ForegroundColor Yellow
$exampleDir = Join-Path $HOME_DIR ".agents\ExampleSubagents"
New-Item -ItemType Directory -Path $exampleDir -Force | Out-Null

Write-Host "    Sozdayu .myskills\skills\" -ForegroundColor Yellow
$mySkillsDir = Join-Path $HOME_DIR ".myskills\skills"
New-Item -ItemType Directory -Path $mySkillsDir -Force | Out-Null

# 3. Копируем ВСЕ скиллы из .agents/skills/ (единый источник)
if (Test-Path (Join-Path $SCRIPT_DIR ".agents\skills")) {
    Write-Host "[3] Kopiruyu skilli..." -ForegroundColor Yellow
    Get-ChildItem (Join-Path $SCRIPT_DIR ".agents\skills") -Directory | Where-Object { $_.Name -ne ".template" } | ForEach-Object {
        $skillName = $_.Name
        $destDir = Join-Path $skillsDir $skillName
        if (Test-Path $destDir) {
            Remove-Item $destDir -Recurse -Force
        }
        Copy-Item $_.FullName $destDir -Recurse -Force
        Write-Host "    [OK] $skillName" -ForegroundColor Green
    }
}

# 4. Копируем примеры субагентов
if (Test-Path (Join-Path $SCRIPT_DIR ".agents\ExampleSubagents")) {
    Write-Host "[4] Kopiruyu primeri subagentov..." -ForegroundColor Yellow
    Get-ChildItem (Join-Path $SCRIPT_DIR ".agents\ExampleSubagents") -Recurse | Where-Object { $_.Name -ne "README.md" -and -not $_.PSIsContainer } | ForEach-Object {
        $relPath = $_.FullName.Substring((Join-Path $SCRIPT_DIR ".agents\ExampleSubagents").Length + 1)
        $destPath = Join-Path $exampleDir $relPath
        $destParent = Split-Path $destPath -Parent
        if (-not (Test-Path $destParent)) {
            New-Item -ItemType Directory -Path $destParent -Force | Out-Null
        }
        Copy-Item $_.FullName $destPath -Force
    }
    Write-Host "    [OK] ExampleSubagents (12 primerov)" -ForegroundColor Green
}

# 5. Создаём .notes\INBOX\
Write-Host "[5] Sozdayu .notes\INBOX\" -ForegroundColor Yellow
$inboxDir = Join-Path $HOME_DIR ".notes\INBOX"
New-Item -ItemType Directory -Path $inboxDir -Force | Out-Null
Write-Host "    [OK] .notes\INBOX sozdana" -ForegroundColor Green

Write-Host ""
Write-Host "+==================================================+" -ForegroundColor Cyan
Write-Host "|          [OK] Ustanovka zavershena!              |" -ForegroundColor Cyan
Write-Host "+==================================================+" -ForegroundColor Cyan
Write-Host ""
Write-Host "Ustanovleno:" -ForegroundColor Green
Write-Host "  [fayl] AGENTS.md         -> $HOME_DIR\AGENTS.md"
Write-Host "  [skill] Skilli           -> $HOME_DIR\.agents\skills\"
Write-Host "  [meta] Meta-orkestraciya -> $HOME_DIR\.agents\skills\meta\orchestration\"
Write-Host "  [creator] Subagent Creator -> $HOME_DIR\.agents\skills\subagent-creator-universal\"
Write-Host "  [primer] Primeri agentov  -> $HOME_DIR\.agents\ExampleSubagents\"
Write-Host "  [user] User Skills        -> $HOME_DIR\.myskills\skills\"
Write-Host "  [note] Zаметki           -> $HOME_DIR\.notes\INBOX\"
Write-Host ""
Write-Host "Sleduyushie shagi:" -ForegroundColor Yellow
Write-Host "  1. Otkroyte vash AI-agent (Qwen, Claude, Cursor...)"
Write-Host "  2. Nachnite noviy chat — agent podkhvatit AGENTS.md"
Write-Host "  3. Ili skazhite: «sleduy AGENTS.md»"
Write-Host "  4. Dlya subagentov: «khochu subagentov» ili «zaspavni agentov»"
Write-Host ""
Write-Host "[i] Dokumentaciya: https://github.com/kissrosecicd-hub/agents-evolution" -ForegroundColor Cyan
Write-Host "[i] Avtor: https://t.me/smartcaveman1" -ForegroundColor Cyan
