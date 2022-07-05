{ inputs
, options
, config
, lib
, pkgs
, ...
}:
with lib;
with lib.my; let
  cfg = config.modules.desktop.extra.dunst;
  dunstDir = "${config.dotfiles.configDir}/dunst";
in
{
  options.modules.desktop.extra.dunst = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    home.services.dunst.enable = true;

    home.configFile."dunst" = {
      source = "${dunstDir}";
      recursive = true;
    };
  };
}
