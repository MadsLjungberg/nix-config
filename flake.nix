# flake.nix  ─ top‑level flake with comments
{
  inputs = {
    nixpkgs.url          = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-wsl.url        = "github:nix-community/NixOS-WSL";
    home-manager.url     = "github:nix-community/home-manager";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
  };

  outputs = inputs@{ self, nixpkgs, nixos-wsl, home-manager, ... }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      # expose every flake to *all* NixOS modules & home‑manager
      specialArgs = { inherit inputs; };

      modules = [
        ./configuration.nix               # base system config
        nixos-wsl.nixosModules.default    # WSL integration
        ./wsl-wezterm.nix                 # cursor+portal+WezTerm tweaks
        home-manager.nixosModules.home-manager  # enable HM
      ];
    };
  };
}

