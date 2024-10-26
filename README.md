# dotfiles

This is my new (under) development dotfiles using Nix

# Install Nix

```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
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
