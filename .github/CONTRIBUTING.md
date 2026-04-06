# Contributing Guide

Спасибо что хотите внести вклад в AGENTS.md! 🙏

## Как начать

1. Форкните репозиторий
2. Создайте ветку (`git checkout -b feature/my-skill`)
3. Внесите изменения
4. Откройте Pull Request

## Добавление нового скилла

### Структура

```
skills/my-skill/
├── SKILL.md              # Обязательный файл с описанием, триггерами, правилами
└── prompts/              # Опционально: промпты для разных сценариев
    └── scenario.md
```

### Требования к SKILL.md

```markdown
---
name: my-skill
description: Краткое описание для авто-определения
---

# Название скилла

## Когда использовать
<!-- Триггеры, сценарии -->

## Правила
<!-- Что агент должен делать -->

## Примеры
<!-- Примеры хорошего поведения -->

## Запреты
<!-- Чего агент НЕ должен делать -->
```

### Чеклист перед PR

- [ ] SKILL.md имеет frontmatter с `name` и `description`
- [ ] Триггеры описаны явно
- [ ] Есть примеры хорошего поведения
- [ ] Нет дубликатов с существующими скиллами
- [ ] README обновлён если добавлен новый скилл

## Установка для тестирования

```bash
# Linux/macOS
./install.sh

# Windows
.\install.ps1
```

## Обсуждения

- Предложить идею скилла → [New Issue: Skill](https://github.com/kissrosecicd-hub/agents-evolution/issues/new?template=skill-submission.md)
- Сообщить о баге → [New Issue: Bug](https://github.com/kissrosecicd-hub/agents-evolution/issues/new?template=bug-report.md)
- Улучшить документацию → [New Issue: Docs](https://github.com/kissrosecicd-hub/agents-evolution/issues/new?template=documentation.md)

## Связь с автором

Telegram: [@smartcaveman1](https://t.me/smartcaveman1)
