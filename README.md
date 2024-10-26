# Install NixOS

```bash
curl -s -L https://nixos.org/nix/install | sh
```

## Configure environment

```bash
nix run nix-darwin --extra-experimental-features "nix-command flakes" -- switch --flake ~/.config/nix#home
```

## Rebuild environment

```bash
darwin-rebuild switch --flake ~/.config/nix#home
```
