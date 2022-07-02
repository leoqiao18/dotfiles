{ config
, options
, lib
, pkgs
, ...
}:
with lib;
with lib.my; let
  cfg = config.modules.develop.diagnostic;
  devCfg = config.modules.develop.xdg;
in
{
  options.modules.develop.diagnostic = {
    enable = mkBoolOpt false;
  };

  config = mkMerge [
    (mkIf cfg.enable {
      user.packages = with pkgs; [
        nodePackages.diagnostic-languageserver
      ];
    })

    (mkIf devCfg.enable {
      # TODO:
    })
  ];
}
