#!/bin/bash

# RobinCLI Installation Script
# This script creates symlinks for all binaries in the bin/ directory
# to a target directory (default: /usr/local/bin).

# Target installation directory
INSTALL_DIR=${1:-$HOME/.local/bin}

# Source directory containing binaries
BIN_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/bin"

echo "Installing RobinCLI binaries to $INSTALL_DIR..."

# Check if INSTALL_DIR exists
if [ ! -d "$INSTALL_DIR" ]; then
    echo "Error: Installation directory $INSTALL_DIR does not exist."
    exit 1
fi

# Check if INSTALL_DIR is writable
if [ ! -w "$INSTALL_DIR" ]; then
    echo "Error: Installation directory $INSTALL_DIR is not writable. Try running with sudo."
    exit 1
fi

# Loop through each binary in BIN_DIR
for BIN_PATH in "$BIN_DIR"/*; do
    if [ -f "$BIN_PATH" ]; then
        BIN_NAME=$(basename "$BIN_PATH")
        
        # Ensure the binary is executable
        chmod +x "$BIN_PATH"
        
        # Create symlink
        echo "Linking $BIN_NAME..."
        ln -sf "$BIN_PATH" "$INSTALL_DIR/$BIN_NAME"
    fi
done

echo "---"
echo "RobinCLI binaries installed successfully to $INSTALL_DIR."

# Check if INSTALL_DIR is in PATH
if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
    echo "Warning: $INSTALL_DIR is not in your PATH."
    echo "You may need to add it to your shell configuration (e.g., .bashrc or .zshrc):"
    echo "export PATH=\"\$PATH:$INSTALL_DIR\""
else
    echo "Success: $INSTALL_DIR is in your PATH. You can now use the binaries from anywhere!"
fi

# Zsh Completion Setup
ZSHRC="$HOME/.zshrc"
COMP_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/completions"

if [ -f "$ZSHRC" ]; then
    echo "---"
    echo "Checking Zsh completion setup..."
    if ! grep -q "$COMP_DIR" "$ZSHRC"; then
        echo "Adding RobinCLI completions to $ZSHRC..."
        echo -e "\n# RobinCLI completions\nfpath=($COMP_DIR \$fpath)\nautoload -Uz compinit && compinit" >> "$ZSHRC"
        echo "Success: Zsh completions activated. Please restart your terminal or run: source ~/.zshrc"
    else
        echo "Success: RobinCLI completions already configured in $ZSHRC."
    fi
fi
