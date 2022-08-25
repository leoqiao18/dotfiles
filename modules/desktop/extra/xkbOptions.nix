{ inputs, options, config, lib, pkgs, ... }:
with lib;
with lib.my;
let cfg = config.modules.desktop.extra.xkbOptions;
in {
  options.modules.desktop.extra.xkbOptions = { enable = mkBoolOpt false; };

  config = mkIf cfg.enable {
    services.xserver.xkbOptions = "ctrl:nocaps";
    services.xserver.displayManager.sessionCommands = ''
      setxkbmap
    '';
  };
}
