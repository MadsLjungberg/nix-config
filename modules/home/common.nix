# home/common.nix  ─ reused on every host
_: {

  home.stateVersion = "24.11"; # keep forever
  programs = {
    fish.enable = true;
    starship.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}

