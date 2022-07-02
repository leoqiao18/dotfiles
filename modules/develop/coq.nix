{ config
, options
, lib
, pkgs
, ...
}:
with lib;
with lib.my; let
  cfg = config.modules.develop.coq;
  devCfg = config.modules.develop.xdg;
in
{
  options.modules.develop.coq = {
    enable = mkBoolOpt false;
  };

  config = mkMerge [
    (mkIf cfg.enable {
      user.packages = with pkgs; [
        coq
      ];
    })

    (mkIf devCfg.enable {
      # TODO:
    })
  ];
}
