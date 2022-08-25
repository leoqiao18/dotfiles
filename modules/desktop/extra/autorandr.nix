{ inputs, options, config, lib, pkgs, ... }:
with lib;
with lib.my;
let cfg = config.modules.desktop.extra.autorandr;
in {
  options.modules.desktop.extra.autorandr = { enable = mkBoolOpt false; };

  config = mkIf cfg.enable {
    home.programs.autorandr = {
      enable = true;
      hooks = { };
    };
  };
}
