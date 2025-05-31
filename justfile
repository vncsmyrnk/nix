default:
  just --list

install-deps:
  sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --daemon

install: install-deps config

config:
  mkdir -p {{home_dir()}}/.config/nix {{home_dir()}}/.config/nixpkgs
  stow -t {{home_dir()}}/.config/nix nix
  stow -t {{home_dir()}}/.config/nixpkgs nixpkgs

unset-config:
  stow -D -t {{home_dir()}}/.config/nix nix
  stow -D -t {{home_dir()}}/.config/nixpkgs nixpkgs
