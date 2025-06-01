default:
  just --list

install-deps:
  sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --daemon
  nix-channel --add https://nixos.org/channels/nixpkgs-unstable unstable

install: install-deps config

config:
  mkdir -p {{home_dir()}}/.config/nix {{home_dir()}}/.config/nixpkgs
  stow -t {{home_dir()}}/.config/nix nix
  stow -t {{home_dir()}}/.config/nixpkgs nixpkgs

unset-config:
  stow -D -t {{home_dir()}}/.config/nix nix
  stow -D -t {{home_dir()}}/.config/nixpkgs nixpkgs

sync-packages:
  nix-env -if ~/.config/nixpkgs/packages.nix

update:
  nix-channel --update
  nix-env -u

update-dry-run:
  nix-channel --update
  nix-env -u --dry-run

update-rollback:
  nix-env --rollback

clean:
  nix-collect-garbage -d

list-generations:
  nix-env --list-generations

delete-old-generations:
  nix-env --delete-generations old
