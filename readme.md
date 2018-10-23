Dotfiles
===

My `dotfiles` for MacOS.

# Installation

```bash
bash -c "`curl -fsSL https://raw.github.com/rapatao/dotfiles/master/setup.sh`"
```

# Customization

## Adding `zgen` plugins

This `dotfiles` uses `zgen` to manage the `zsh` plugins.

To add your desired plugins to your `zsh` environment you must add them (using the `zgen` syntax) in the folder `${HOME}/.dotfiles.d/zsh`.

## Adding custom alias and scripts

### Aliases
You can add a custom alias for your environment creating files that export the desired alias in the folder `${HOME}/.dotfiles.d/alias`

* Example:

```zsh
#!/bin/zsh

alias ls="ls -G"
```

### Scripts
You can add custom scripts that you want to be available in your `$PATH` creating files in the folder `${HOME}/.dotfiles.d/bin`

# Updating

The `dotfiles-update` script provides a simple way to update the `dotfiles`. During the script execution, it will update the `zgen`, this `dotfiles` scripts, the `homebrew` installed packages and your `dotfiles.d` when versioned using `git`.

* Usage:
```zsh
dotfiles-update
```

# References

* homebrew -> https://brew.sh/
* zgen -> https://github.com/tarjoilija/zgen
* dotfiles -> https://dotfiles.github.io/

# Note
I've never installed this "dotfiles" in a clean MacOS installation so I'm not sure if some manual process could be required to achieve a successful installation. (please, creates an issue if you have some errors during the installation process)