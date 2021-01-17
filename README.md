# `nix-darwin-compat`

This is a collection of [`nix-darwin`](https://github.com/LnL7/nix-darwin) modules distributed as a Nix flake that mimics some NixOS modules to allow more configuration sharing.

## Available modules

The only module available for now is the `flake-registry` module, which adds a `nix.registry` option, similar to [the one present in NixOS](https://nixos.org/manual/nixos/stable/options.html#opt-nix.registry).

## Usage

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    darwin.url = "github:LnL7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    darwin-compat.url = "github:sandhose/nix-darwin-compat";
  };

  outputs = { self, nixpkgs, darwin, darwin-compat }: {
    darwinConfigurations."example" = darwin.lib.darwinSystem {
      modules = [
        { pkgs, ... }: {
          nix = {
            package = pkgs.nixFlakes;
            registry.nixpkgs.flake = nixpkgs; # Option added by nix-darwin-compat
            extraOptions = ''
              experimental-features = nix-command flakes
            '';
          };
        }
        darwin-compat.darwinModules.flake-registry
      ];
    };
  };
}
```
