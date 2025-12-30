# CLI Bypass Permissions Guide

Dokumentasi dan installer untuk bypass permission prompts pada berbagai AI CLI tools.

**Supported Platforms:** Termux (Android), Linux Mint, Ubuntu, macOS

**Last Updated:** 2025-12-30 (Added GLM support & 29 bypass flags)

---

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

| CLI | Bypass Flag | Alias | Status |
|-----|-------------|-------|--------|
| Claude | `--dangerously-skip-permissions` | `claude` | ✅ Updated (29 calls) |
| Gemini | `--yolo` atau `--approval-mode yolo` | `gemini` | ✅ Active |
| Droid | `--skip-permissions-unsafe` | `droid` | ✅ Active |
| GLM/ZhipuAI | `--dangerously-skip-permissions` | `glm` | ✅ New |
| Letta | - (tidak ada) | - | N/A |

---

## Aliases yang Di-install

```bash
alias claude="claude --dangerously-skip-permissions"
alias gemini="gemini --yolo"
alias droid="droid exec --skip-permissions-unsafe"
alias glm="claude --dangerously-skip-permissions"  # For GLM users
```

---

## 🆕 What's New (2025-12-30)

### Claude Code Updates
- **claude-all** now includes **29 bypass flags** across all model calls
- Added support for **GLM models** (ZhipuAI):
  - glm-4.7 (Latest flagship 2025)
  - glm-4.6 (High performance)
  - glm-4.5-air (Fast & efficient)
  - glm-4.6v & glm-4.5v (Vision models)
- All 29 `exec claude` calls now use `--dangerously-skip-permissions`

### Improvements
- Better model selection UI with numbered menu
- Removed 10 non-working experimental models
- Added tested & working models only
- Cleaner interface with categories (Latest, Vision, etc.)

---

## Detail per CLI

### Claude Code

```bash
# Langsung bypass
claude --dangerously-skip-permissions

# Atau dengan alias (setelah install)
claude

# claude-all multi-model launcher (NEW!)
claude-all
# Pilih model 1-29 atau tekan ENTER untuk default
```

**Features:**
- ✅ 29 `exec claude` calls with bypass enabled
- ✅ Multi-model support (Anthropic, OpenAI, Google, xAI, GLM, etc.)
- ✅ Numbered model selection menu
- ✅ GLM models integrated (glm-4.7, glm-4.6, glm-4.5-air, vision models)
- ✅ Auto-bypass on all model selections

**Download manual:**
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

### GLM / ZhipuAI

```bash
# Via claude-all (recommended)
claude-all
# Pilih option 7 (ZhipuAI / GLM)
# Pilih model 1-5:
#   1) glm-4.7     (Latest flagship)
#   2) glm-4.6     (High performance)
#   3) glm-4.5-air (Fast & efficient)
#   4) glm-4.6v    (Vision model)
#   5) glm-4.5v    (Vision model)

# Atau langsung dengan API
export ANTHROPIC_BASE_URL="https://api.z.ai/api/anthropic"
export ANTHROPIC_API_KEY="your-glm-api-key"
claude --dangerously-skip-permissions --model glm-4.7
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
echo 'alias glm="claude --dangerously-skip-permissions"' >> ~/.bashrc
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
- `~/.bashrc` - alias untuk claude, gemini, droid, glm
- `$PREFIX/bin/claude-all` (Termux) atau `/usr/local/bin/claude-all` (Linux)

---

## Files

```
scripts/
├── install.sh      # One-line installer script
└── claude-all      # Multi-model launcher with bypass enabled (29 bypass flags)
```

---

## Uninstall

```bash
# Remove aliases from bashrc
sed -i '/alias claude=/d' ~/.bashrc
sed -i '/alias gemini=/d' ~/.bashrc
sed -i '/alias droid=/d' ~/.bashrc
sed -i '/alias glm=/d' ~/.bashrc

# Remove claude-all (Termux)
rm $PREFIX/bin/claude-all

# Remove claude-all (Linux)
sudo rm /usr/local/bin/claude-all

# Reload
source ~/.bashrc
```

---

## Verification

Cek apakah bypass sudah aktif:

```bash
# Cek jumlah bypass flags di claude-all
grep -c "dangerously-skip-permissions" $(which claude-all)
# Output: 29

# Test claude
claude --help | grep "dangerously-skip-permissions"

# Test claude-all
claude-all
# Pilih model dan lihat apakah permission bypass aktif
```

---

## Troubleshooting

**Q: Aliases tidak bekerja?**
A: Pastikan sudah `source ~/.bashrc` atau buka terminal baru.

**Q: claude-all tidak bisa diakses?**
A: Cek permission dengan `ls -l $(which claude-all)` dan pastikan executable.

**Q: GLM model tidak muncul di claude-all?**
A: Update ke versi terbaru:
```bash
curl -fsSL https://raw.githubusercontent.com/zesbe/cli-bypass-docs/main/scripts/claude-all -o $PREFIX/bin/claude-all
chmod +x $PREFIX/bin/claude-all
```

---

*Last updated: 2025-12-30*
*Repository: https://github.com/zesbe/cli-bypass-docs*
*Author: zesbe*
