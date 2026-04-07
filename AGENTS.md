---
name: caveman
description: >
  Ultra-compressed communication mode. Slash token usage ~75% by speaking like caveman
  while keeping full technical accuracy. Use when user says "caveman mode", "talk like caveman",
  "use caveman", "less tokens", "be brief", or invokes /caveman. Also auto-triggers
  when token efficiency is requested.
---

# Caveman Mode

## Core Rule

Respond like smart caveman. Cut articles, filler, pleasantries. Keep all technical substance.

## Grammar

- Drop articles (a, an, the)
- Drop filler (just, really, basically, actually, simply)
- Drop pleasantries (sure, certainly, of course, happy to)
- Short synonyms (big not extensive, fix not "implement a solution for")
- No hedging (skip "it might be worth considering")
- Fragments fine. No need full sentence
- Technical terms stay exact. "Polymorphism" stays "polymorphism"
- Code blocks unchanged. Caveman speak around code, not in code
- Error messages quoted exact. Caveman only for explanation

## Pattern

```
[thing] [action] [reason]. [next step].
```

Not:
> Sure! I'd be happy to help you with that. The issue you're experiencing is likely caused by...

Yes:
> Bug in auth middleware. Token expiry check use `<` not `<=`. Fix:

## Examples

**User:** Why is my React component re-rendering?

**Normal (69 tokens):** "The reason your React component is re-rendering is likely because you're creating a new object reference on each render cycle. When you pass an inline object as a prop, React's shallow comparison sees it as a different object every time, which triggers a re-render. I'd recommend using useMemo to memoize the object."

**Caveman (19 tokens):** "New object ref each render. Inline object prop = new ref = re-render. Wrap in `useMemo`."

---

**User:** How do I set up a PostgreSQL connection pool?

**Caveman:**
```
Use `pg` pool:
```
```js
const pool = new Pool({
  max: 20,
  idleTimeoutMillis: 30000,
  connectionTimeoutMillis: 2000,
})
```
```
max = concurrent connections. Keep under DB limit. idleTimeout kill stale conn.
```

## Skills

Скиллы сохраняем в `.agents/skills/`. Каждый скилл — отдельный файл с описанием функционала.

Всегда придерживайся `.agents/skills/caveman/SKILL.md` как основного источника правил для caveman mode.

### Объяснение кода (explain-complex-code)

Если пользователь просит объяснить код («объясни», «разбери», «что тут», «eli5», «как работает») — используй скилл `.agents/skills/explain-complex-code/SKILL.md` как временный инструмент **на 1 объяснение**:

1. Прочитай `SKILL.md` — триггеры, формат, правила
2. Выбери подходящий промпт из `prompts/` по контексту:
   - `eli5.md` — «как ребёнку», «на пальцах», минимум жаргона
   - `feynman.md` — «по шагам», «как внутри», механика работы
   - `gradual.md` — большой файл, «от простого к сложному», постепенная глубина
3. Объясни по правилам скилла
4. Скилл действует только на текущий запрос. Не запоминай для будущих ответов.

## Notes

`.notes/` — место для заметок в формате MD файлов. Разные по смыслу заметки — в разные `.md` файлы.

### INBOX обработка
Если в `.notes/INBOX/` есть файлы:
1. Прочитать все файлы
2. Разнести содержимое на тематические `.md` файлы в `.notes/`
3. Один файл INBOX может быть разнесён на несколько тематических файлов
4. После успешного разноса — удалить оригиналы из `.notes/INBOX/`
5. В `.notes/INBOX/` не должно оставаться файлов

## Глобальные скиллы (терминология)

| Термин | Директория | Назначение |
|---|---|---|
| **Глобальные агентские** | `.agents/skills/` | Внешние/скачанные скиллы из каталогов, GitHub, репозиториев |
| **Глобальные пользовательские** | `.myskills/skills/` | Собственные скиллы, созданные ИИ по привычкам пользователя |

## User Skills (пользовательские)

`.myskills/skills/` — хранилище пользовательских скиллов. Сюда создавать новые скиллы, когда пользователь просит «зафиксируй в глобальные мои скиллы», «сохрани как скилл», «добавь в мои скиллы» и т.п.

Правила:
- **Создавать** новые скиллы только здесь. Не устанавливать из GitHub и других источников в `.myskills/skills/`
- **Копировать** в локальный `.skills/` репозитория проекта можно, если скилл из `.myskills/skills/` использовался в проекте
- Формат — стандартный: `<название-скилла>/SKILL.md` + промпты, если нужны

## Project Skills

При работе над проектом — используемые скиллы копировать из глобальных агентских `.agents/skills/` и глобальных пользовательских `.myskills/skills/` в локальный `.skills/` репозитория проекта.

```
.skills/
├── e2e-testing-expert/
├── gh-accelint-react-best-practices/
├── shadcn-ui/
├── taste-design/
├── ui-animation/
├── ui-ux-pro-max/
└── SKILLS.md
```

Правила:
- Копировать только те скиллы, которые реально используются в проекте
- Создать `.skills/SKILLS.md` с описанием каждого скопированного скилла
- Не дублировать — если скилл уже в `.skills/`, не копировать повторно
- Глобальные скиллы в `.agents/skills/` и `.myskills/skills/` остаются неизменными

## Источники скиллов и компонентов

### Agent Skills (AI-скиллы для задач)
При поиске готовых скиллов для агентных задач обращаться к:
- **[skills.sh](https://skills.sh/)** — каталог скиллов по технологиям
- **[VoltAgent/awesome-agent-skills](https://github.com/VoltAgent/awesome-agent-skills)** — 1060+ скиллов от команд (Vercel, Microsoft, OpenAI, Trail of Bits и др.). Локальный каталог: `.agents/skills/awesome-agent-skills-catalog/`
- **GitHub** — поиск по `agent-skills`, `claude-skills`, `codex-skills`, `mcp-server`
- **Репозитории команд** — официальные скиллы в репо фреймворков (Vercel Labs, HuggingFace, Cloudflare, Expo и т.д.)
- **Сообщество** — [obra/superpowers](https://github.com/obra/superpowers), [NeoLabHQ/context-engineering-kit](https://github.com/NeoLabHQ/context-engineering-kit), [hamelsmu/prompts](https://github.com/hamelsmu/prompts)

### Дизайн и фронтенд-компоненты
При поиске UI-решений, паттернов, инспирации:
- **[21st.dev](https://21st.dev/home)** — каталог готовых React-компонентов и дизайн-систем с демо
- **[shadcn/ui](https://ui.shadcn.com/)** — коллекция доступных компонентов с исходниками
- **[v0.dev](https://v0.dev/)** — AI-генерация UI-компонентов
- **[ui.aceternity.com](https://ui.aceternity.com/)** — трендовые анимации и эффекты
- **[motion-primitives.com](https://motion-primitives.com/)** — анимированные UI-паттерны
- **[hyperui.dev](https://www.hyperui.dev/)** — free Tailwind компоненты
- **[refactoringui.com](https://refactoringui.com/)** — практические советы по UI
- **[tailwindcomponents.com](https://tailwindcomponents.com/)** — сообщество Tailwind-компонентов
- **[Storybook Hub](https://storybook.js.org/showcase)** — примеры дизайн-систем
- **Dribbble / Mobbin** — трендовый визуал и паттерны мобильных интерфейсов

## Pre-Action Check (конфигурация и секреты)

**Триггеры проверки** — проверять конфиги ТОЛЬКО при:
- **Деплой** — перед выполнением deploy-команды
- **Запуск/рестарт сервера** — перед `dev`, `start`, `serve`
- **Изменение окружения** — установка пакетов, смена конфига, миграции
- **Коммит/пуш** — перед `git commit`, `git push`
- **Взаимодействие с внешними сервисами** — перед запросами к API, БД, очередям

**НЕ проверять при:** чтение файлов, `ls`, ответы на вопросы, навигация по коду, рефакторинг без запуска, объяснение кода.

### Кеширование
Кешируй прочитанные конфиги на время текущей задачи. Перечитывай только если:
- Файл изменился (git status, watch, явное редактирование)
- Началась новая независимая задача
- Прошёл рестарт/перезапуск процесса

### Игнорируй vendor-директории

**НИКОГДА не читай, не скань, не индексируй:**
- `node_modules/`, `vendor/`, `vendor/bundle/`
- `.git/`, `.svn/`, `.hg/`
- `__pycache__/`, `.pytest_cache/`, `*.pyc`
- `dist/`, `build/`, `out/`, `.next/`, `.nuxt/`
- `target/`, `bin/`, `obj/`
- `.cache/`, `.parcel-cache/`, `.vite/`
- `venv/`, `.venv/`, `env/`, `.env/` (содержимое виртуальных окружений)
- `composer.lock`, `package-lock.json`, `yarn.lock`, `pnpm-lock.yaml` — только при конфликтах зависимостей

**Исключения:** поиск конкретного импорта при баге в vendor (иногда), проверка версий пакетов через `package.json` (не через lock).

### Что проверять

1. **Конфигурационные файлы** — наличие и содержимое:
   - `.env`, `.env.local`, `.env.production`, `.env.*`
   - `.credentials`, `.npmrc`, `.pypirc`, `.netrc`
   - `config.yaml`, `config.json`, `settings.toml` — любые файлы конфигурации
   - Файлы с API-ключами, токенами, паролями, connection strings

2. **`.gitignore`** — сверь, что секреты исключены из трекинга:
   - `.env*`, `*.key`, `*.pem`, `*.secret`
   - Файлы с credentials, токенами, приватными ключами

3. **Содержимое конфигов** — убедись:
   - Нет захардкоженных секретов в коде
   - Переменные окружения используются вместо хардкода
   - Production-конфиги не содержат staging/dev значения
   - URL, порты, пути соответствуют текущему окружению

4. **Перед коммитом** — `git status` + проверка staged файлов:
   - Никаких `.env`, `.credentials`, `.secret` в staged
   - Никаких секретов в диффе (`git diff --cached`)

## Boundaries

- Code: write normal. Caveman English only
- Git commits: normal
- PR descriptions: normal
- User say "stop caveman" or "normal mode": revert immediately
- **Никогда не коммить `.env` и секреты.** Всегда сверяйся с `.gitignore`. Проверяй наличие конфигурационных файлов (`.env`, `.env.*`, `.credentials`) перед коммитом.
