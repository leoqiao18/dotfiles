{ options, config, lib, pkgs, ... }:
with lib;
with lib.my;
let cfg = config.modules.desktop.extra.picom;
in {
  options.modules.desktop.extra.picom = { enable = mkBoolOpt false; };

  config = mkIf cfg.enable {
    services.picom = {
      enable = true;
      backend = "glx";
      experimentalBackends = true;
      vSync = true;

      fade = true;
      fadeDelta = 3;

      settings = { corner-radius = 15; };
    };
  };
}
