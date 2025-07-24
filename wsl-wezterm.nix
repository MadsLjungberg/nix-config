# wsl-wezterm.nix ─ system‑level cursor + portal helper
{ config, lib, pkgs, ... }:
lib.mkIf config.wsl.enable {
  environment.systemPackages = with pkgs; [
    adwaita-icon-theme xdg-desktop-portal xdg-desktop-portal-gtk wezterm
  ];
}

