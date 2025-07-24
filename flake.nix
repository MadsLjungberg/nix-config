# flake.nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    home-manager.url = "github:nix-community/home-manager";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
  };

  # We wrap outputs in a let so we can reuse `system`, `pkgs`, `lib`
  outputs = inputs@{ nixpkgs, nixos-wsl, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      inherit (nixpkgs) lib;
    in
    {
      # ---- Make sure `nix fmt`works ----
      formatter.${system} = pkgs.nixpkgs-fmt;

      # ---- Dev shell you can enter with: nix develop .#dev ----
      devShells.${system}.dev = pkgs.mkShell {
        packages = with pkgs; [
          deadnix
          statix
          nixpkgs-fmt
          pre-commit
          just
        ];
        shellHook = ''
          echo "🔧 Dev shell ready. Run ./scripts/ci.sh"
        '';
      };

      # Optional: so `nix fmt` works
      formatter.${system} = pkgs.nixpkgs-fmt;

      # ---- Your NixOS system ----
      nixosConfigurations.nixos = lib.nixosSystem {
        inherit system; # <— replaces `system = system;`
        specialArgs = { inherit inputs; }; # pass all inputs to every module

        modules = [
          ./configuration.nix
          nixos-wsl.nixosModules.default
          ./wsl-wezterm.nix
          home-manager.nixosModules.home-manager
        ];
      };
    };
}

