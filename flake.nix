{
  description = "Some nix-darwin modules porting NixOS configurations options to allow more configuration sharing";

  outputs = { self }: {
    darwinModules = {
      flake-registry = import ./modules/flake-registry.nix;
    };
  };
}
