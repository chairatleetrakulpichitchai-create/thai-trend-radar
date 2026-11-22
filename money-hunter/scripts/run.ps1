# รันทีมหนึ่งบทบาท: .\scripts\run.ps1 scout|builder|review
# ตั้งใน Task Scheduler: Program = powershell.exe
#   Arguments = -ExecutionPolicy Bypass -File "C:\path\money-hunter\scripts\run.ps1" scout
param([Parameter(Mandatory=$true)][ValidateSet("scout","builder","review")][string]$Role)
$ErrorActionPreference = "Stop"
Set-Location (Join-Path $PSScriptRoot "..")
New-Item -ItemType Directory -Force logs, reports | Out-Null
$prompt = Get-Content "prompts\$Role.md" -Raw -Encoding UTF8
$log = "logs\$(Get-Date -Format yyyy-MM-dd)-$Role.log"
claude -p $prompt --permission-mode acceptEdits --allowedTools "Read,Write,Edit,Glob,Grep,WebSearch,WebFetch" *>> $log
