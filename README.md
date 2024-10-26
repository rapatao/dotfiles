# dotfiles

This is my new (under) development dotfiles using NixOS

# Install NixOS

```bash
curl -s -L https://nixos.org/nix/install | sh
```

## Configure environment

```bash
mkdir -p ~/.config/nix && \
    curl -sSL https://github.com/rapatao/dotfiles/archive/refs/heads/master.zip | \
    bsdtar -C ~/.config/nix --strip-components=1 -xvf- "dotfiles-master/." && \
    nix run nix-darwin -- switch --flake ~/.config/nix#home    
```

## Updating packages

```bash
nix flake update --flake ~/.config/nix/ && darwin-rebuild switch --flake ~/.config/nix#home
```
