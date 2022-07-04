{ config
, options
, lib
, pkgs
, ...
}:
with lib;
with lib.my; let
  cfg = config.modules.desktop.terminal.kitty;
  kittyDir = "${config.dotfiles.configDir}/kitty";
  active = config.modules.themes.active;
in
{
  options.modules.desktop.terminal.kitty = with types; {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    user.packages = with pkgs; [ kitty ];

    home.configFile."kitty" = {
      source = "${kittyDir}";
      recursive = true;
    };
  };
}
