{ inputs, options, config, lib, pkgs, ... }:
with lib;
with lib.my;
let
  cfg = config.modules.desktop.extra.xmobar;
  configDir = config.dotfiles.configDir;
in {
  options.modules.desktop.extra.xmobar = { enable = mkBoolOpt false; };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ haskellPackages.xmobar ];

    home.configFile = {
      "xmobar" = {
        source = "${configDir}/xmobar";
        recursive = true;
      };
    };
  };
}
