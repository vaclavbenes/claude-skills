#!/bin/bash

# Exit on error
set -e

# Color definitions
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Define skills to install
SKILLS=("confluence" "github" "grill-me" "jira-cli" "teamcity-cli" "weasyprint")

# Get the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Target directories
CLAUDE_TARGET="$HOME/.claude/skills"
ANTIGRAVITY_TARGET="$HOME/.gemini/config/skills"

show_help() {
    echo "Usage: $0 [options]"
    echo ""
    echo "Options:"
    echo "  --claude        Install skills for Claude Code only"
    echo "  --antigravity   Install skills for Antigravity AI only"
    echo "  --both          Install skills for both Claude and Antigravity"
    echo "  -h, --help      Show this help message"
    echo ""
    echo "If no options are provided, the script will attempt to auto-detect installations."
}

# Parse command line options
FORCE_CLAUDE=false
FORCE_ANTIGRAVITY=false
FORCE_BOTH=false

while [[ $# -gt 0 ]]; do
    case "$1" in
        --claude)
            FORCE_CLAUDE=true
            shift
            ;;
        --antigravity|--gemini)
            FORCE_ANTIGRAVITY=true
            shift
            ;;
        --both)
            FORCE_BOTH=true
            shift
            ;;
        -h|--help)
            show_help
            exit 0
            ;;
        *)
            echo -e "${RED}Unknown option: $1${NC}"
            show_help
            exit 1
            ;;
    esac
done

echo -e "${BLUE}=== Skill Installer for Claude & Antigravity ===${NC}"

# Function to install skills to a target directory
install_skills() {
    local target_dir="$1"
    local system_name="$2"
    
    echo -e "${GREEN}Installing skills to $system_name directory: $target_dir...${NC}"
    mkdir -p "$target_dir"
    
    for skill in "${SKILLS[@]}"; do
        if [ -d "$SCRIPT_DIR/$skill" ]; then
            echo -e "  Copying $skill..."
            # Remove existing version if it exists to avoid nested copying issues
            rm -rf "$target_dir/$skill"
            cp -R "$SCRIPT_DIR/$skill" "$target_dir/"
        else
            echo -e "${YELLOW}  Warning: Skill folder '$skill' not found in $SCRIPT_DIR${NC}"
        fi
    done
    echo -e "${GREEN}Successfully installed skills to $system_name!${NC}"
}

# Determine target installations
INSTALL_CLAUDE=false
INSTALL_ANTIGRAVITY=false

if [ "$FORCE_BOTH" = true ]; then
    INSTALL_CLAUDE=true
    INSTALL_ANTIGRAVITY=true
elif [ "$FORCE_CLAUDE" = true ]; then
    INSTALL_CLAUDE=true
elif [ "$FORCE_ANTIGRAVITY" = true ]; then
    INSTALL_ANTIGRAVITY=true
else
    # Auto-detection
    # 1. Detect Claude Code
    if [ -d "$HOME/.claude" ] || command -v claude &>/dev/null; then
        echo -e "${GREEN}Detected Claude Code installation.${NC}"
        INSTALL_CLAUDE=true
    fi

    # 2. Detect Antigravity AI
    if [ -d "$HOME/.gemini" ] || command -v antigravity &>/dev/null; then
        echo -e "${GREEN}Detected Antigravity AI installation.${NC}"
        INSTALL_ANTIGRAVITY=true
    fi
fi

# Apply actions
if [ "$INSTALL_CLAUDE" = true ]; then
    install_skills "$CLAUDE_TARGET" "Claude Code"
fi

if [ "$INSTALL_ANTIGRAVITY" = true ]; then
    install_skills "$ANTIGRAVITY_TARGET" "Antigravity AI"
fi

# If nothing was installed
if [ "$INSTALL_CLAUDE" = false ] && [ "$INSTALL_ANTIGRAVITY" = false ]; then
    echo -e "${YELLOW}No active installation of Claude Code or Antigravity AI was detected.${NC}"
    
    # Check if running interactively
    if [ -t 0 ]; then
        echo -e "Please choose one of the following options to install the skills anyway:"
        echo -e "  1) Install for Claude Code (creates $CLAUDE_TARGET)"
        echo -e "  2) Install for Antigravity AI (creates $ANTIGRAVITY_TARGET)"
        echo -e "  3) Install for both"
        echo -e "  4) Exit without installing"
        
        read -p "Enter your choice (1-4): " choice
        case "$choice" in
            1)
                install_skills "$CLAUDE_TARGET" "Claude Code"
                ;;
            2)
                install_skills "$ANTIGRAVITY_TARGET" "Antigravity AI"
                ;;
            3)
                install_skills "$CLAUDE_TARGET" "Claude Code"
                install_skills "$ANTIGRAVITY_TARGET" "Antigravity AI"
                ;;
            *)
                echo -e "${RED}Installation cancelled.${NC}"
                exit 1
                ;;
        esac
    else
        echo -e "${RED}Error: Non-interactive shell and no installation targets detected.${NC}"
        echo -e "Use --claude, --antigravity, or --both to force installation."
        exit 1
    fi
fi

echo -e "${GREEN}Installation completed successfully!${NC}"
