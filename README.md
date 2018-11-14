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

# Updating the `dotfiles`

The `dotfiles-update` script provides a simple way to update the `dotfiles`. During the script execution, it will update the `zgen`, this `dotfiles` scripts, the `homebrew` installed packages and your `dotfiles.d` when versioned using `git`.

* Usage:
```zsh
dotfiles-update
```

# Installing a `dotfiles.d`

The `dotfiles-profile` provides a simple way to clone your `dotfiles.d` repository in the expected folder. Note that the command `dotfiles-update` will update this folder when it identifies that the directory is a git repository.

To install you must use the following command
```zsh
dotfiles-profile -i <git repository uri>
```

For more details, run:
```zsh
dotfiles-profile -h
```

## Important
All directories/files in the `symlinks` folder will be used to create a symbolic link in your `HOME` using the same name.

This will let you manage your configurations, like `maven` or even `ssh`.

In cases where you need to change permissions or run other tasks after the installation, you can create a file named `_setup.sh` in each directory containing the required instructions. This file will be executed every time that you install or change the `dotfiles.d` profile.

* Example of `symlinks` folder:

```
$ tree                                                                                                                    .
├── .m2
│   └── settings.xml
└── .ssh
    ├── _setup.sh
    ├── config
    └── id_rsa
```

# References

* homebrew -> https://brew.sh/
* zgen -> https://github.com/tarjoilija/zgen
* dotfiles -> https://dotfiles.github.io/

# Note
I've never installed this "dotfiles" in a clean MacOS installation so I'm not sure if some manual process could be required to achieve a successful installation. (please, creates an issue if you have some errors during the installation process)
