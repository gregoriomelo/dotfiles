#!/bin/bash
# scripts/post-setup.sh
# Post-setup checklist and next steps guide after bootstrap installation

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Colors & Formatting
BOLD="\033[1m"
GREEN="\033[32m"
YELLOW="\033[33m"
CYAN="\033[36m"
BLUE="\033[34m"
RESET="\033[0m"

echo -e "\n${BOLD}=====================================================${RESET}"
echo -e "${BOLD}       DOTFILES POST-SETUP: RECOMMENDED NEXT STEPS   ${RESET}"
echo -e "${BOLD}=====================================================${RESET}"

# 1. Default Shell (Nushell)
echo -e "\n${BOLD}[1/5] Shell Configuration (Nushell)...${RESET}"
NU_IN_SHELLS=false
USER_HAS_NU=false

if grep -q "/opt/homebrew/bin/nu" /etc/shells 2>/dev/null; then
    NU_IN_SHELLS=true
fi

USER_SHELL=$(dscl . -read "$HOME" UserShell 2>/dev/null | awk '{print $2}')
if [ "$USER_SHELL" = "/opt/homebrew/bin/nu" ]; then
    USER_HAS_NU=true
fi

if [ "$NU_IN_SHELLS" = true ] && [ "$USER_HAS_NU" = true ]; then
    echo -e "  ${GREEN}✅ Nushell is registered in /etc/shells and set as your login shell.${RESET}"
else
    echo -e "  ${YELLOW}⚠️ Nushell is installed, but not set as your login shell.${RESET}"
    echo -e "     Current shell: ${USER_SHELL:-unknown}"
    echo -e "     ${CYAN}→ Action:${RESET} Run ${BOLD}make default-shell${RESET} (registers in /etc/shells and calls chsh)."
    echo -e "     ${CYAN}→ Note:${RESET}   After running it, fully quit Ghostty/Terminal (${BOLD}Cmd+Q${RESET}) and relaunch."
fi

# 2. Services & Daemons
echo -e "\n${BOLD}[2/5] Services & Daemons...${RESET}"

# Tailscale
if command -v tailscale >/dev/null 2>&1; then
    if tailscale status >/dev/null 2>&1; then
        echo -e "  ${GREEN}✅ Tailscale daemon is running and connected.${RESET}"
    else
        echo -e "  ${YELLOW}⚠️ Tailscale is installed, but the daemon is not running or authenticated.${RESET}"
        echo -e "     ${CYAN}→ Action:${RESET} Start daemon:   ${BOLD}sudo brew services start tailscale${RESET}"
        echo -e "     ${CYAN}→ Action:${RESET} Authenticate:   ${BOLD}sudo tailscale up${RESET}"
    fi
else
    echo -e "  ${CYAN}ℹ️ Tailscale CLI not found.${RESET}"
fi

# Colima (Docker runtime)
if command -v colima >/dev/null 2>&1; then
    if colima status >/dev/null 2>&1; then
        echo -e "  ${GREEN}✅ Colima (Docker container runtime) is running.${RESET}"
    else
        echo -e "  ${CYAN}ℹ️ Colima (Docker container runtime) is installed but stopped.${RESET}"
        echo -e "     ${CYAN}→ Action:${RESET} Run ${BOLD}colima start${RESET} when ready to use Docker."
    fi
fi

# 3. CLI Authentication & Secrets
echo -e "\n${BOLD}[3/5] CLI Authentication & Secrets...${RESET}"

# GitHub CLI
if command -v gh >/dev/null 2>&1; then
    if gh auth status >/dev/null 2>&1; then
        echo -e "  ${GREEN}✅ GitHub CLI (gh) is authenticated.${RESET}"
    else
        echo -e "  ${YELLOW}⚠️ GitHub CLI (gh) is not logged in.${RESET}"
        echo -e "     ${CYAN}→ Action:${RESET} Run ${BOLD}gh auth login${RESET} to connect your GitHub account."
    fi
fi

# Proton Pass CLI
if command -v pass-cli >/dev/null 2>&1; then
    if pass-cli info >/dev/null 2>&1; then
        echo -e "  ${GREEN}✅ Proton Pass CLI (pass-cli) is authenticated.${RESET}"
    else
        echo -e "  ${YELLOW}⚠️ Proton Pass CLI (pass-cli) is not logged in.${RESET}"
        echo -e "     ${CYAN}→ Action:${RESET} Run ${BOLD}pass-cli login${RESET} (required by env.nu to load CONTEXT7_API_KEY)."
    fi
fi

# Atuin
if command -v atuin >/dev/null 2>&1; then
    if atuin status >/dev/null 2>&1; then
        echo -e "  ${GREEN}✅ Atuin shell history sync is logged in.${RESET}"
    else
        echo -e "  ${CYAN}ℹ️ Atuin is recording history locally, but sync server is unauthenticated.${RESET}"
        echo -e "     ${CYAN}→ Action:${RESET} Run ${BOLD}atuin login${RESET} or ${BOLD}atuin register${RESET} if syncing history across machines."
    fi
fi

# AI Coding Agents
echo -e "  ${CYAN}ℹ️ AI coding tools installed:${RESET}"
echo -e "     • Claude Code:  Run ${BOLD}claude login${RESET} or set ANTHROPIC_API_KEY"
echo -e "     • Context7 MCP: Ensure CONTEXT7_API_KEY is in .env or Proton Pass"

# 4. macOS Privacy & Accessibility Permissions
echo -e "\n${BOLD}[4/5] macOS App Permissions (System Settings)...${RESET}"
echo -e "  Several installed GUI apps require manual permissions in:"
echo -e "  ${BOLD}System Settings > Privacy & Security${RESET}:"
echo -e "     • ${BOLD}Alfred:${RESET}      Grant ${CYAN}Accessibility${RESET} & ${CYAN}Full Disk Access${RESET} (disable Spotlight Cmd+Space if desired)"
echo -e "     • ${BOLD}Magnet:${RESET}      Grant ${CYAN}Accessibility${RESET} (for window snapping keybindings)"
echo -e "     • ${BOLD}f.lux:${RESET}       Grant ${CYAN}Location Services${RESET} (for sunrise/sunset color temperature)"

# 5. Session & Reboot
echo -e "\n${BOLD}[5/5] Relaunch & Reboot Recommendations...${RESET}"
echo -e "  • ${BOLD}Restart Terminal:${RESET} Fully quit (${BOLD}Cmd+Q${RESET}) Ghostty or Terminal.app and reopen."
echo -e "  • ${BOLD}System Reboot:${RESET}    Log out or restart macOS so all system defaults take effect."
echo -e "  • ${BOLD}Health Check:${RESET}     Run ${BOLD}make health-check${RESET} at any time to validate your setup."

echo -e "\n${BOLD}=====================================================${RESET}\n"
