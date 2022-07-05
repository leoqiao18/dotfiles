{ inputs
, options
, config
, lib
, pkgs
, ...
}:
with lib;
with lib.my; let
  cfg = config.modules.desktop.xmonad;
  # configDir = config.dotfiles.configDir;
in
{
  config = mkIf cfg.enable {
    services.dbus = {
      enable = true;
    };
  };
}
