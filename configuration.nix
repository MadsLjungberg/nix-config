# configuration.nix ─ only host/global settings
{ config, lib, pkgs, ... }:

{
  # allow proprietary pkgs (vscode, claude)
  nixpkgs.config.allowUnfree = true;

  # global pkgs (WSL‑agnostic)
  environment.systemPackages = with pkgs; [
    git
    vscode
    claude-code
    jujutsu
  ];

  # -------- Home‑Manager users --------
  home-manager.users.nixos.imports =
    [ ./modules/home/common.nix ./cachix.nix ]                                 # fish, starship, direnv
    ++ lib.optional config.wsl.enable ./modules/home/wsl.nix; # WezTerm tweak only in WSL

  # WSL basics
  wsl.enable = true;
  wsl.defaultUser = "nixos";

  # nix settings
  nix.settings = {
    trusted-users = [ "root" "nixos" ];
    substituters = [
      "https://cache.nixos.org"
      "https://devnixosconfig.cachix.org" #for the cache util.
    ];
    trusted-public-keys = [
      "devnixosconfig.cachix.org-1:XmF+A7pzAUwiTNqctuBLGL3JFFFXc66L98/InocCdUQ="
    ];
  };

  # nix-experimental
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "24.11";
}

