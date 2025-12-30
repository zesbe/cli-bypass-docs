# CLI Bypass Permissions Guide

Dokumentasi dan installer untuk bypass permission prompts pada berbagai AI CLI tools.

**Supported Platforms:** Termux (Android), Linux Mint, Ubuntu, macOS

## One-Line Installer

### Termux (Android)
```bash
curl -fsSL https://raw.githubusercontent.com/zesbe/cli-bypass-docs/main/scripts/install.sh | bash
```

### Linux Mint / Ubuntu
```bash
curl -fsSL https://raw.githubusercontent.com/zesbe/cli-bypass-docs/main/scripts/install.sh | bash
```

### macOS
```bash
curl -fsSL https://raw.githubusercontent.com/zesbe/cli-bypass-docs/main/scripts/install.sh | zsh
```

---

## Quick Reference

| CLI | Bypass Flag | Alias |
|-----|-------------|-------|
| Claude | `--dangerously-skip-permissions` | `claude` |
| Gemini | `--yolo` atau `--approval-mode yolo` | `gemini` |
| Droid | `--skip-permissions-unsafe` | `droid` |
| Letta | - (tidak ada) | - |

## Aliases yang Di-install

```bash
alias claude="claude --dangerously-skip-permissions"
alias gemini="gemini --yolo"
alias droid="droid exec --skip-permissions-unsafe"
```

---

## Detail per CLI

### Claude Code

```bash
# Langsung bypass
claude --dangerously-skip-permissions

# Atau dengan alias (setelah install)
claude
```

**claude-all** sudah dimodifikasi dengan 37 `exec claude` menggunakan flag bypass.

Download manual:
```bash
# Termux
curl -fsSL https://raw.githubusercontent.com/zesbe/cli-bypass-docs/main/scripts/claude-all -o $PREFIX/bin/claude-all
chmod +x $PREFIX/bin/claude-all

# Linux
sudo curl -fsSL https://raw.githubusercontent.com/zesbe/cli-bypass-docs/main/scripts/claude-all -o /usr/local/bin/claude-all
sudo chmod +x /usr/local/bin/claude-all
```

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

---

## Manual Installation

Jika tidak ingin pakai installer otomatis:

### 1. Tambah aliases ke ~/.bashrc

```bash
echo 'alias claude="claude --dangerously-skip-permissions"' >> ~/.bashrc
echo 'alias gemini="gemini --yolo"' >> ~/.bashrc
echo 'alias droid="droid exec --skip-permissions-unsafe"' >> ~/.bashrc
source ~/.bashrc
```

### 2. Download claude-all (optional)

```bash
# Termux
curl -fsSL https://raw.githubusercontent.com/zesbe/cli-bypass-docs/main/scripts/claude-all -o $PREFIX/bin/claude-all && chmod +x $PREFIX/bin/claude-all

# Linux
sudo curl -fsSL https://raw.githubusercontent.com/zesbe/cli-bypass-docs/main/scripts/claude-all -o /usr/local/bin/claude-all && sudo chmod +x /usr/local/bin/claude-all
```

---

## Persistence

Semua konfigurasi persist setelah reboot:
- `~/.bashrc` - alias untuk claude, gemini, droid
- `$PREFIX/bin/claude-all` (Termux) atau `/usr/local/bin/claude-all` (Linux)

---

## Files

```
scripts/
├── install.sh      # One-line installer script
└── claude-all      # Multi-model launcher with bypass enabled
```

---

## Uninstall

```bash
# Remove aliases from bashrc
sed -i '/alias claude=/d' ~/.bashrc
sed -i '/alias gemini=/d' ~/.bashrc
sed -i '/alias droid=/d' ~/.bashrc

# Remove claude-all (Termux)
rm $PREFIX/bin/claude-all

# Remove claude-all (Linux)
sudo rm /usr/local/bin/claude-all

# Reload
source ~/.bashrc
```

---

*Last updated: 2025-12-30*
*Author: zesbe*
