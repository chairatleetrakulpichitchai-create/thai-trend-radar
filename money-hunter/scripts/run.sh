#!/usr/bin/env bash
# รันทีมหนึ่งบทบาท: ./scripts/run.sh scout|builder|review
# crontab ตัวอย่าง (เวลาเครื่อง):
#   10 6  * * *  /path/money-hunter/scripts/run.sh scout
#   40 13 * * *  /path/money-hunter/scripts/run.sh builder
#   20 19 * * 0  /path/money-hunter/scripts/run.sh review
set -euo pipefail
ROLE="${1:?usage: run.sh scout|builder|review}"
cd "$(dirname "$0")/.."
mkdir -p logs reports
claude -p "$(cat "prompts/${ROLE}.md")" \
  --permission-mode acceptEdits \
  --allowedTools "Read,Write,Edit,Glob,Grep,WebSearch,WebFetch" \
  >> "logs/$(date +%F)-${ROLE}.log" 2>&1
