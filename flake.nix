{
  description = "Some nix-darwin modules porting NixOS configurations options to allow more configuration sharing";

  outputs = { self }: {
    darwinModules = {
      flake-registry = import ./modules/flake-registry.nix;
      fontdir = import ./modules/fontdir.nix;
      all = {
        imports = [
          ./modules/flake-registry.nix
          ./modules/fontdir.nix
        ];
      };
    };
  };
}
