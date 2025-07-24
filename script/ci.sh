mkdir -p scripts
cat > scripts/ci.sh <<'EOF'
#!/usr/bin/env bash
set -euo pipefail

echo "👉 deadnix"
nix run nixpkgs#deadnix -- -f

echo "👉 statix"
nix run nixpkgs#statix -- check .

echo "👉 nix flake check"
nix flake check --show-trace

echo "👉 smoke build (nixos)"
nix build .#nixosConfigurations.nixos.config.system.build.toplevel --print-build-logs
EOF
chmod +x scripts/ci.sh

