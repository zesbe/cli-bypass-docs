# CLI Bypass Permissions Guide

Dokumentasi untuk bypass permission prompts pada berbagai AI CLI tools di Termux.

## Quick Reference

| CLI | Bypass Flag | Alias |
|-----|-------------|-------|
| Claude | `--dangerously-skip-permissions` | `claude` |
| Gemini | `--yolo` atau `--approval-mode yolo` | `gemini` |
| Droid | `--skip-permissions-unsafe` | `droid` |
| Letta | - (tidak ada) | - |

## Aliases di ~/.bashrc

```bash
alias claude="claude --dangerously-skip-permissions"
alias gemini="gemini --yolo"
alias droid="droid exec --skip-permissions-unsafe"
```

## Detail per CLI

### Claude Code

```bash
# Langsung bypass
claude --dangerously-skip-permissions

# Atau dengan alias
claude
```

**claude-all** sudah dimodifikasi dengan 37 `exec claude` menggunakan flag bypass.
Lokasi: `/data/data/com.termux/files/usr/bin/claude-all`

### Gemini CLI

```bash
# Cara 1
gemini --yolo

# Cara 2
gemini --approval-mode yolo

# Mode tersedia:
# - default     : Minta approval untuk setiap aksi
# - auto_edit   : Auto-approve edit tools saja
# - yolo        : Auto-approve SEMUA tools
```

### Droid CLI (Factory)

```bash
# Full bypass
droid exec --skip-permissions-unsafe "prompt"

# Autonomy levels:
# (default)     : Read-only, paling aman
# --auto low    : File ops dasar
# --auto medium : Dev ops (npm, git commit, build)
# --auto high   : Production (git push, deploy)
# --skip-permissions-unsafe : FULL BYPASS
```

### Letta

Letta tidak punya sistem permission sendiri karena merupakan wrapper/agent manager yang menggunakan model dari provider lain.

## Cara Aktivasi

```bash
# Reload bashrc
source ~/.bashrc

# Atau buka terminal baru
```

## Persistence

Semua konfigurasi persist setelah reboot:
- `~/.bashrc` - alias untuk claude, gemini, droid
- `/data/data/com.termux/files/usr/bin/claude-all` - 37 exec claude dengan bypass

---

*Last updated: 2025-12-30*
