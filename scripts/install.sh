#!/usr/bin/env bash

# CLI Bypass Permissions Installer
# Supports: Termux (Android) & Linux (Mint, Ubuntu, etc.)
# Repository: https://github.com/zesbe/cli-bypass-docs

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}=======================================${NC}"
echo -e "${BLUE}  CLI Bypass Permissions Installer${NC}"
echo -e "${BLUE}=======================================${NC}"
echo ""

# Detect platform
detect_platform() {
    if [[ -d "/data/data/com.termux" ]]; then
        echo "termux"
    elif [[ "$(uname -s)" == "Linux" ]]; then
        echo "linux"
    elif [[ "$(uname -s)" == "Darwin" ]]; then
        echo "macos"
    else
        echo "unknown"
    fi
}

PLATFORM=$(detect_platform)
echo -e "${GREEN}Platform detected: ${PLATFORM}${NC}"

# Set paths based on platform
if [[ "$PLATFORM" == "termux" ]]; then
    BIN_DIR="/data/data/com.termux/files/usr/bin"
    BASHRC="$HOME/.bashrc"
elif [[ "$PLATFORM" == "linux" ]] || [[ "$PLATFORM" == "macos" ]]; then
    BIN_DIR="/usr/local/bin"
    BASHRC="$HOME/.bashrc"
    [[ "$PLATFORM" == "macos" ]] && BASHRC="$HOME/.zshrc"
else
    echo -e "${RED}Unsupported platform${NC}"
    exit 1
fi

echo -e "${YELLOW}Binary directory: ${BIN_DIR}${NC}"
echo -e "${YELLOW}Shell config: ${BASHRC}${NC}"
echo ""

# Function to add alias if not exists
add_alias() {
    local alias_name="$1"
    local alias_cmd="$2"
    local alias_line="alias ${alias_name}=\"${alias_cmd}\""

    if grep -q "alias ${alias_name}=" "$BASHRC" 2>/dev/null; then
        echo -e "${YELLOW}Alias '${alias_name}' already exists, updating...${NC}"
        # Remove old alias
        sed -i "/alias ${alias_name}=/d" "$BASHRC"
    fi

    echo "$alias_line" >> "$BASHRC"
    echo -e "${GREEN}Added: ${alias_line}${NC}"
}

# Install aliases
echo -e "${BLUE}Installing bypass aliases...${NC}"
echo ""

# Claude
if command -v claude &> /dev/null; then
    add_alias "claude" "claude --dangerously-skip-permissions"
else
    echo -e "${YELLOW}Claude CLI not found, skipping alias${NC}"
fi

# Gemini
if command -v gemini &> /dev/null; then
    add_alias "gemini" "gemini --yolo"
else
    echo -e "${YELLOW}Gemini CLI not found, skipping alias${NC}"
fi

# Droid
if command -v droid &> /dev/null; then
    add_alias "droid" "droid exec --skip-permissions-unsafe"
else
    echo -e "${YELLOW}Droid CLI not found, skipping alias${NC}"
fi

# GLM (ZhipuAI)
if command -v claude &> /dev/null; then
    add_alias "glm" "claude --dangerously-skip-permissions"
    echo -e "${GREEN}GLM alias added (uses claude with bypass)${NC}"
else
    echo -e "${YELLOW}Claude CLI not found, skipping GLM alias${NC}"
fi

echo ""

# Download and install claude-all (optional)
echo -e "${BLUE}Do you want to install claude-all with bypass? (y/n)${NC}"
read -r install_claude_all

if [[ "$install_claude_all" =~ ^[Yy]$ ]]; then
    echo -e "${BLUE}Downloading claude-all...${NC}"

    CLAUDE_ALL_URL="https://raw.githubusercontent.com/zesbe/cli-bypass-docs/main/scripts/claude-all"

    if [[ "$PLATFORM" == "termux" ]]; then
        curl -fsSL "$CLAUDE_ALL_URL" -o "$BIN_DIR/claude-all"
        chmod +x "$BIN_DIR/claude-all"
    else
        sudo curl -fsSL "$CLAUDE_ALL_URL" -o "$BIN_DIR/claude-all"
        sudo chmod +x "$BIN_DIR/claude-all"
    fi

    echo -e "${GREEN}claude-all installed to ${BIN_DIR}/claude-all${NC}"
fi

echo ""
echo -e "${GREEN}=======================================${NC}"
echo -e "${GREEN}  Installation Complete!${NC}"
echo -e "${GREEN}=======================================${NC}"
echo ""
echo -e "${YELLOW}Run this command to activate:${NC}"
echo -e "${BLUE}  source ${BASHRC}${NC}"
echo ""
echo -e "${YELLOW}Or open a new terminal.${NC}"
echo ""
echo -e "${BLUE}Bypass commands available:${NC}"
echo "  claude  -> claude --dangerously-skip-permissions"
echo "  gemini  -> gemini --yolo"
echo "  droid   -> droid exec --skip-permissions-unsafe"
echo "  glm     -> claude --dangerously-skip-permissions (GLM/ZhipuAI)"
echo ""
echo -e "${YELLOW}🆕 claude-all includes 29 bypass flags for all models!${NC}"
echo ""
