#!/bin/bash

# Ensure /mnt/hgfs directory exists
sudo mkdir -p /mnt/hgfs

# Check for KaliShared folder from VMware
if [ -d "/mnt/hgfs/KaliShared" ]; then
    echo "[✓] KaliShared is already mounted via VMware."
else
    echo "[!] KaliShared not found under /mnt/hgfs. Ensure shared folders are enabled in VMware Fusion Pro."
fi

# Create symlink to ~/KaliShared if not already present
if [ ! -L "$HOME/KaliShared" ]; then
    ln -s /mnt/hgfs/KaliShared "$HOME/KaliShared"
    echo "[✓] Symlink created: ~/KaliShared → /mnt/hgfs/KaliShared"
else
    echo "[i] Symlink already exists at ~/KaliShared."
fi

# Add alias to .zshrc if not already present
if ! grep -Fxq "alias shared='cd ~/KaliShared'" ~/.zshrc; then
    echo "alias shared='cd ~/KaliShared'" >> ~/.zshrc
    echo "[✓] Alias 'shared' added to ~/.zshrc"
else
    echo "[i] Alias 'shared' already exists in ~/.zshrc"
fi

echo "[✔] Shared folder setup complete. Run 'source ~/.zshrc' or restart terminal to use 'shared' command."
