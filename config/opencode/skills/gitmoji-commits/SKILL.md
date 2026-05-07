---
name: gitmoji-commits
description: "Create semantic git commits with gitmoji and Conventional Commits. Use this whenever the user asks to commit, stage changes, split work into multiple commits, choose emojis, or improve commit-message quality."
license: MIT
metadata:
  version: "1.1.0"
---

# Gitmoji Commits

Create clean, intentional commits with the right emoji and scope.

## Workflow (use in order)

1. **Inspect working tree**
   - Run: `git status --short` and `git diff --stat`
   - Identify file groups by intent (feature, fix, docs, tests, config).

2. **Plan commit boundaries**
   - Split unrelated work into separate commits.
   - Use `git add -p` for mixed files.

3. **Choose emoji (core-first)**
   - Preferred: `bash scripts/gitmoji_selector.sh --emoji-only "<change summary>"`
   - If unsure/rare case: consult `references/gitmoji-guide.md`.

4. **Draft commit message**
   - Format: `emoji type(scope): subject`
   - Keep subject imperative and concise (<= 50 chars).

5. **Stage only intended changes**
   - Run: `git add <file>` or `git add -p`
   - Re-check with: `git diff --cached --stat`.

6. **Safety check before commit**
   - Ensure no secrets, debug logs, or accidental churn.
   - Ensure commit content matches the message.

7. **Commit and repeat**
   - Run: `git commit -m "<message>"`
   - Repeat until working tree is clean.

## Commit Format

```text
✨ feat(auth): Add two-factor login
```

Optional body:

```text
✨ feat(auth): Add two-factor login

- Add TOTP enrollment and verification
- Update auth service and user model

Closes #123
```

## Type Guide

Use Conventional Commit types:
`feat`, `fix`, `refactor`, `docs`, `test`, `perf`, `style`, `chore`, `ci`, `build`

Common scopes: `auth`, `api`, `ui`, `db`, `ci`, `deps`

## Core Emoji Map (auto-detected)

| Type | Emoji | Keywords |
|------|-------|----------|
| Feature | ✨ | add, new, implement |
| Bug fix | 🐛 | fix, bug, error |
| Simple fix | 🩹 | typo, quick, one-liner |
| Documentation | 📝 | docs, readme, changelog |
| Tests | 🧪 | test, spec, integration |
| Refactor | ♻️ | refactor, extract, restructure |
| Performance | ⚡ | optimize, perf, cache |
| UI/Styles | 💄 | css, style, ui, theme |
| Dependencies | 📦 | npm, dependency, package |
| Security | 🔐 | security, cve, xss |
| Config | ⚙️ / 🔧 | config, setup, settings |
| Remove | 🗑️ | remove, delete, deprecate |
| Major | 🔨 | rewrite, redesign, architect |
| Deploy | 🚀 | deploy, release, ship |
| SEO | 🔍 | seo, metadata |
| i18n | 🗣️ | translate, locale |
| Linter | 🚨 | eslint, prettier |
| Automation | 🔄 | github actions, workflow |
| Test pass | ✅ | tests passing, green build |
| Upgrade deps | ⬆️ | upgrade, bump |
| Downgrade deps | ⬇️ | downgrade |
| Types/Tag | 🏷️ | type definitions, version tags |
| Copy/Text | 💬 | copy, strings, text |
| Comments/Notes | 💡 | comment, todo, note |
| Mocks | 🎭 | mock, stub |

## Special Cases (highest priority)

| Emoji | When |
|-------|------|
| ⏪ | Revert commits |
| 🔀 | Merge commits |
| 🚑 | Hotfix |
| 🚧 | WIP |

## Helper Script

```bash
# Emoji only (fast)
bash scripts/gitmoji_selector.sh --emoji-only "fix critical bug"

# JSON suggestion
bash scripts/gitmoji_selector.sh "update api docs"

# Full Conventional Commit
bash scripts/gitmoji_selector.sh --conventional feat auth "Add login"
```
