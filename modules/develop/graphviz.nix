{ config, options, lib, pkgs, ... }:
with lib;
with lib.my;
let
  cfg = config.modules.develop.graphviz;
  devCfg = config.modules.develop.xdg;
in {
  options.modules.develop.graphviz = { enable = mkBoolOpt false; };

  config = mkMerge [
    (mkIf cfg.enable { user.packages = with pkgs; [ graphviz ]; })

    (mkIf devCfg.enable {
      # TODO:
    })
  ];
}
