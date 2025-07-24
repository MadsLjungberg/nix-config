# NixOS Flake Config (WSL + Home‑Manager)

## Quick bootstrap on a new machine

> **Prereqs**: Nix >= 2.4 with flakes enabled, or NixOS already installed.

```bash
# 1) Clone (HTTPS or SSH)
sudo rm -rf /etc/nixos #if etc/nixos already exists.
sudo git clone https://github.com/MadsLjungberg/nix-config /etc/nixos   # or: git@github.com:<you>/nix-config.git

# 2) Rebuild (choose your host attr: wsl, nixos, laptop, etc.)
sudo nixos-rebuild switch --flake /etc/nixos#nixos
