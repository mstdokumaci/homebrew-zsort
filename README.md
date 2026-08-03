# zsort tap

Homebrew tap for [zsort](https://github.com/mstdokumaci/zsort), an
opinionated import organizer for Zig.

## Install

```sh
brew tap mstdokumaci/zsort
brew install mstdokumaci/zsort/zsort
```

The formula builds from source with a keg-only `zig@0.15` — your own Zig
installation is never touched or upgraded (zsort requires Zig 0.15.2+ and
supports 0.16).

## Upgrade

```sh
brew upgrade zsort
```

## Uninstall

```sh
brew uninstall zsort
brew untap mstdokumaci/zsort
```
