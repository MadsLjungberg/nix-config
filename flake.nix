# flake.nix  ─ top‑level flake with comments
{
  inputs = {
    nixpkgs.url          = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-wsl.url        = "github:nix-community/NixOS-WSL";
    home-manager.url     = "github:nix-community/home-manager";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
  };

  outputs = inputs@{ self, nixpkgs, nixos-wsl, home-manager, ... }: 
  let
	system = "x86_64-linux";
  in {

    devShells.${system}.dev = nixpkgs.mkShell {
	packages = with nixpkgs; [
		deadnix
		statix
		nixpkgs-fmt
		pre-commit
		just
	      ];
	shellHook = ''
		echo "🔧Dev shell ready. Run ./scripts/ci.sh"
		'';
	};

    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = system

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

