{ inputs
, options
, config
, lib
, pkgs
, ...
}:
with lib;
with lib.my; let
  cfg = config.modules.desktop;
in
{
  config = mkIf cfg.xmonad.enable {
    services.xserver.xkbOptions = "ctrl:nocaps";
    services.xserver.displayManager.sessionCommands = ''
      setxkbmap
    '';
  };
}
