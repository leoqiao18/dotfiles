{ config, options, lib, pkgs, ... }:
with lib;
with lib.my;
let
  cfg = config.modules.develop.latex;
  devCfg = config.modules.develop.xdg;
in {
  options.modules.develop.latex = { enable = mkBoolOpt false; };

  config = mkMerge [
    (mkIf cfg.enable {
      user.packages = with pkgs; [ texlab texlive.combined.scheme-full ];
    })

    (mkIf devCfg.enable {
      # TODO:
    })
  ];
}
