{ lib, config, pkgs, ... }:
(import ../group.nix { inherit lib config; } "developer").packages [
  # development
  pkgs.jq
  pkgs.yq-go
  pkgs.git
  pkgs.git-crypt
  pkgs.ripgrep
  pkgs.fd

  # editors
  pkgs.vim
  pkgs.neovim
  pkgs.nixpkgs-fmt
  pkgs.tree-sitter

  # c lang
  pkgs.cmake
  pkgs.ninja

  # javascript
  pkgs.nodejs
  pkgs.yarn
  pkgs.google-clasp

  # go lang
  pkgs.go
  pkgs.golangci-lint
  pkgs.delve

  # rust
  pkgs.cargo

  # testing
  pkgs.k6

  # ai agents
  pkgs.claude-code
  pkgs.antigravity-cli

  # others
  pkgs.github-cli
]
