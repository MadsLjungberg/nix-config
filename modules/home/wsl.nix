# home/wsl.nix ─ extra bits only for WSL users
{ ... }: {
  programs.wezterm = {
    enable = true;
    extraConfig = ''return { enable_wayland = false }'';
  };
  xdg = {
    configFile."wezterm/wezterm.lua".text = ''return { enable_wayland = false }'';
  };
}

