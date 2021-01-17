{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.fonts.fontDir;

in

{

  options = {
    fonts.fontDir = {

      enable = mkOption {
        type = types.bool;
        default = false;
        description = ''
          Whether to enable font management and install configured fonts to
          <filename>/Library/Fonts</filename>.

          NOTE: removes any manually-added fonts.
        '';
      };

      decompressFonts = mkOption {
        type = types.bool;
        default = false;
        description = ''
          This option is only here for NixOS compatibility.
        '';
      };

    };
  };

  config = mkIf cfg.enable {
    fonts.enableFontDir = true;

    warnings = mkIf cfg.decompressFonts [
      "fonts.fontDir.decompressFonts does nothing on nix-darwin"
    ];
  };

  imports = [
    (mkRenamedOptionModule [ "fonts" "enableFontDir" ] [ "fonts" "fontDir" "enable" ])
  ];
}
