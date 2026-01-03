# AGENTS.md (dotfiles)

This repo is a Home Manager + Nix flake configuration for a personal/dev environment.
Agentic coding assistants should optimize for **safe, reviewable changes** (avoid applying system changes unless explicitly requested).

## Repo entrypoints

- `flake.nix` defines Home Manager configurations under `homeConfigurations`.
  - There may be serveral, such as one for personal use and another for work.
- `home.nix` is the top-level Home Manager module; it imports `programs/*` modules.
- `setup.sh` bootstraps Nix + Home Manager, then runs a `home-manager switch`.
  - It uses network (`curl`) and may use `sudo` (Darwin spotlight + shell changes).

## Common commands (build / lint / test)

### Build / "test" (safe)

There is no conventional unit-test suite in this repo. Treat **building/evaluating** the flake as the primary "test".

- Build a single Home Manager activation package (fastest targeted check):
  - `nix build .#homeConfigurations.mthadley-home.activationPackage`
  - `nix build .#homeConfigurations.mthadley-workos.activationPackage`
- Build via Home Manager (also safe, does not apply):
  - `home-manager build --flake "path:.#mthadley-home"`
- Evaluate / sanity-check the flake (may fetch inputs if missing):
  - `nix flake check`
  - `nix eval .#homeConfigurations.mthadley-home.config.home.username`

### Targeted checks (single "test" equivalents)

When you want the fastest possible confidence check:

- Avoid creating a `result` symlink: `nix build --no-link .#homeConfigurations.mthadley-home.activationPackage`
- Sanity-check a specific option evaluates: `nix eval .#homeConfigurations.mthadley-home.config.programs.neovim.enable`
- Validate Nix parses/formatting on one file: `nixpkgs-fmt --check home.nix`

### Apply (unsafe / user-confirm)

**Only** run these when the user explicitly asks to apply changes:

- Apply configuration to the current machine:
  - `home-manager switch --flake "path:.#mthadley-home"`
- Bootstrap install (network + sudo side-effects):
  - `HOME_MANAGER_CONFIG=mthadley-home ./setup.sh`

### Lint / format

These are the repo's "lint" equivalents.

- Nix formatting:
  - Format everything: `rg --files -g'*.nix' | xargs nixpkgs-fmt`
  - Format one file: `nixpkgs-fmt flake.nix`
- Lua formatting (Neovim config):
  - Format all Lua: `stylua programs/neovim/config/lua`
  - Format one file: `stylua programs/neovim/config/lua/mthadley/init.lua`
  - Note: the Home Manager-managed config lives at `~/.config/stylua/.stylua.toml`.
- Fish formatting:
  - Format one file in-place: `fish_indent -w programs/fish/config.fish`
- Shell linting:
  - `shellcheck setup.sh`

## Code style guidelines

### General

- Prefer small, focused diffs; avoid drive-by refactors.
- Keep generated artifacts out of the repo; this repo is source config.
- Avoid editing `flake.lock` unless intentionally updating inputs.
  - If updating inputs, prefer `nix flake lock --update-input <name>` and describe why.

### Nix (`*.nix`)

- Formatting:
  - Use `nixpkgs-fmt` (matches Neovim formatter name `nixpkgs_fmt`).
  - 2-space indentation; no manual alignment columns.
- File structure (common pattern):
  - Module header like `{ pkgs, ... }:` (or `{ config, pkgs, lib, ... }:` when needed).
  - Blank line, then `{ ... }` body.
- Imports:
  - Central imports live in `home.nix` (`imports = [ ./programs/... ];`).
  - Keep imports stable and roughly grouped by domain.
- Prefer Home Manager idioms:
  - `home.file` for dotfile placement.
  - `home.sessionVariables` for environment.
  - `lib.optionals` / `lib.optionalAttrs` for platform conditionals.
- Naming:
  - Attribute names are lowerCamelCase (Home Manager conventions), strings often kebab-case.
  - Derivation names are short and descriptive (`name = "base16";`).
- Errors / safety:
  - Avoid embedding host-specific absolute paths unless gated (see Darwin `SSH_AUTH_SOCK`).
  - When adding platform-specific behavior, use `pkgs.stdenv.isDarwin` / `isLinux` checks.

### Lua (Neovim config under `programs/neovim/config/`)

- Formatting:
  - Use `stylua` (the repo already installs it via Home Manager).
  - Don't hand-format; let the formatter decide indentation/tabs.
- Imports / requires:
  - Use `local mod = require("...")` at the top when a module is mandatory.
  - For optional/dynamic loads, use `pcall(require, ...)` and emit a helpful error.
    - See `programs/neovim/config/lua/mthadley/init.lua`.
- Naming:
  - Prefer `snake_case` for locals (`user_config_dir`, `gray_bg`).
  - Use `local` by default; avoid leaking globals.
  - Namespace groups/augroup names as `mthadley:<topic>`.
- API usage:
  - Prefer `vim.api.nvim_*` functions and structured tables over stringly Vimscript.
  - Keep keymaps centralized (see `mappings.lua`) unless filetype-specific.
- Error handling:
  - Fail soft in UI code: don't crash Neovim startup for optional features.
  - When printing errors, include the module/key context.

### Fish (`programs/fish/**/*.fish`)

- Formatting:
  - Use `fish_indent` to format; indent with 4 spaces.
- Functions:
  - Functions live in `programs/fish/functions/*.fish` and are deployed via Home Manager.
  - Use `function name --description "..."` for discoverability.
- Variables:
  - Use `set -l` for locals inside functions, `set -g` for explicit globals.
  - Quote variables when used as strings; don't rely on implicit splitting.
- Errors:
  - For invalid usage, print a clear message and `return 1`.
  - Prefer `argparse` for option parsing (see `swatch.fish`).

### Shell scripts (`*.sh`)

- Bash is only used for initial setup (see `setup.sh`).
- Safety defaults:
  - Start with `set -eou pipefail`.
  - Guard side-effectful operations with clear checks and messages.
- Lint:
  - Run `shellcheck` on edited scripts.
- Portability:
  - Expect both macOS and Linux; gate OS-specific behavior with `uname` checks.

## Making changes safely

- Prefer validating by building the activation package (`nix build ...activationPackage`).
- Don't run `./setup.sh` or `home-manager switch` unless the user asked.
- When touching Neovim config, keep changes contained to `programs/neovim/config/`.
- When adding new tools/packages, update `home.nix` (packages list) and/or the relevant `programs/*.nix` module.
