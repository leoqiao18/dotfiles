{ options
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
  config = mkIf (cfg.xmonad.enable) {
    services.picom = {
      enable = true;
      backend = "glx";
      experimentalBackends = true;
      vSync = true;

      fade = true;
      fadeDelta = 3;

      settings = {
        corner-radius = 10;
      };
    };
  };
}
