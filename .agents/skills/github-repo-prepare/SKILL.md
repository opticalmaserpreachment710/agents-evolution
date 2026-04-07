---
name: github-repo-prepare
description: "Подготовить проект к публикации на GitHub: .gitignore, аудит безопасности, README.md, LICENSE, .env.example, скриншоты, проверка имени."
triggers:
  - "подготовь к публикации"
  - "подготовь к гитхаб"
  - "github prepare"
  - "подготовить репозиторий"
  - "подготовка к публикации"
  - "сделай README для гитхаб"
  - "скриншоты для README"
  - "подготовь репо"
  - "github prep"
---

# GitHub Repository Preparation

## КРИТИЧНО: Проверка имени проекта

```bash
PROJECT_NAME=$(basename "$PWD")
```

| Имя | Можно на GitHub? |
|-----|------------------|
| `my-project` | ✅ Да |
| `my-project-private` | ❌ **НЕТ** |
| `*-private` | ❌ **НЕТ** |

**Правило:** если директория проекта заканчивается на `-private` — **КАТЕГОРИЧЕСКИ НЕЛЬЗЯ** на GitHub. Это личное. Скажи пользователю:

> ⚠️ Проект `*-private` — личное использование, не для GitHub.

## Пошаговый план

### 1. Проверка и создание .gitignore

**Убедись что .gitignore покрывает:**

```gitignore
# Dependencies
node_modules/

# Build output
.next/
out/
dist/

# Environment variables (НЕ коммитить!)
.env
.env.local
.env.*.local

# TypeScript
*.tsbuildinfo

# Testing
test-results/
playwright-report/
playwright/.cache/
blob-report/
coverage/

# Runtime data
data/*.sqlite
data/*.db
data/*.db-wal
data/*.db-shm
data/*.json
data/*.csv

# Logs
*.log
npm-debug.log*

# IDE
.vscode/*
!.vscode/extensions.json
!.vscode/settings.json
.idea/
*.swp

# OS
.DS_Store
Thumbs.db

# Local skills/notes
.skills/
.mynotes/
```

**Добавь специфичное** по стеку проекта (Python → `__pycache__/`, Go → `bin/`, и т.д.).

### 2. Запуск audit-gitignore.sh

Если есть `scripts/audit-gitignore.sh` — запусти:

```bash
bash scripts/audit-gitignore.sh
```

Если нет — предложи создать (см. ниже).

Скрипт проверяет:
- Какие файлы реально игнорируются
- Опасные файлы которые МОГУТ попасть в коммит
- Скан на секреты в коде (API keys, passwords, private keys)
- Рекомендации по .gitignore

### 3. Создание .env.example

Скопируй `.env` → `.env.example`, **удали все значения**:

```bash
# Пример .env.example:
PORT=
BROWSER=
DATABASE_URL=
API_KEY=
```

НЕ копируй реальные секреты!

### 4. README.md

Структура:

```markdown
# Project Name

Короткое описание — что делает проект.

![Screenshot](screenshots/light-theme.png)
![Dark mode](screenshots/dark-theme.png)

## Фичи

- Фича 1
- Фича 2

## Установка

\`\`\`bash
git clone <url>
cd project
npm install
cp .env.example .env
npm run dev
\`\`\`

## Технологии

- Tech 1
- Tech 2

## Лицензия

[MIT](LICENSE)
```

### 5. Скриншоты

Для веб-приложений — сделай скриншоты через Playwright:

```ts
// tests/screenshots.spec.ts
import { test } from '@playwright/test';

test('screenshot', async ({ page }) => {
  await page.goto('http://localhost:3000');
  await page.waitForLoadState('networkidle');
  await page.screenshot({ path: 'screenshots/light.png', fullPage: true });
});
```

```bash
mkdir -p screenshots
npx playwright test tests/screenshots.spec.ts
```

**CLI-проектам** скриншоты не нужны — достаточно ASCII-демо или gif.

### 6. LICENSE

По умолчанию — MIT:

```
MIT License

Copyright (c) <year> <author>

Permission is hereby granted...
```

### 7. package.json "private"

Для публикации:

```json
{
  "private": false
}
```

Для библиотек — убери `"private"` или поставь `false`.
Для приложений — можно оставить `true`, но тогда это не npm-пакет.

### 8. git init + первый коммит

```bash
git init
git branch -m main
git add -A
git commit -m "feat: initial release

<описание проекта>"
git remote add origin https://github.com/<owner>/<repo>.git
git push -u origin main
```

**ПЕРЕД push:** убедись что репозиторий создан на GitHub.

## audit-gitignore.sh — Шаблон скрипта

Скрипт: `scripts/audit-gitignore.sh`

Проверяет:
- Какие файлы реально игнорируются
- Опасные файлы которые МОГУТ попасть в коммит
- Скан на секреты в коде (API keys, passwords, private keys)
- Рекомендации по .gitignore

## Быстрый чеклист

| Шаг | Команда | Зачем |
|-----|---------|-------|
| 1 | Проверь `-private` в имени | Безопасность |
| 2 | Создай `.gitignore` | Не коммитить лишнее |
| 3 | `bash scripts/audit-gitignore.sh` | Проверка |
| 4 | Создай `.env.example` | Шаблон без секретов |
| 5 | Создай `README.md` | Документация |
| 6 | Сделай скриншоты | Визуал |
| 7 | Создай `LICENSE` | Лицензия |
| 8 | `"private": false` в package.json | Для npm |
| 9 | `git init && git add -A && git commit` | Первый коммит |
| 10 | `git remote add origin && git push` | Публикация |
