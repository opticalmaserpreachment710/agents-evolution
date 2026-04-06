# AGENTS.md Evolution

Эволюция AGENTS.md — от базовой версии к прокаченной.

## Структура

| Файл | Описание |
|---|---|
| `AGENTS-base.md` | Базовая (эволюционная начальная) версия — caveman mode + skills + notes + project skills |
| `AGENTS-enhanced.md` | Прокаченная версия — всё из базы + раздел «Источники скиллов и компонентов» |
| `diff.patch` | Unified diff между версиями |

## Разница: что добавлено в прокаченную версию

### Новый раздел: «Источники скиллов и компонентов»

**Agent Skills (AI-скиллы для задач):**
- skills.sh — каталог скиллов по технологиям
- VoltAgent/awesome-agent-skills — 1060+ скиллов от команд (Vercel, Microsoft, OpenAI, Trail of Bits)
- GitHub — поиск по agent-skills, claude-skills, codex-skills, mcp-server
- Репозитории команд — официальные скиллы в репо фреймворков
- Сообщество — obra/superpowers, NeoLabHQ/context-engineering-kit, hamelsmu/prompts

**Дизайн и фронтенд-компоненты:**
- 21st.dev — каталог готовых React-компонентов и дизайн-систем
- shadcn/ui — коллекция доступных компонентов с исходниками
- v0.dev — AI-генерация UI-компонентов
- ui.aceternity.com — трендовые анимации и эффекты
- motion-primitives.com — анимированные UI-паттерны
- hyperui.dev — free Tailwind компоненты
- refactoringui.com — практические советы по UI
- tailwindcomponents.com — сообщество Tailwind-компонентов
- Storybook Hub — примеры дизайн-систем
- Dribbble / Mobbin — трендовый визуал и паттерны мобильных интерфейсов

## Итог

**Базовая версия** = 115 строк, core функционал
**Прокаченная версия** = 138 строк, +23 строки ссылок на внешние ресурсы

Прокаченная версия даёт агенту готовые источники для поиска скиллов и UI-компонентов без необходимости гадать где искать.
