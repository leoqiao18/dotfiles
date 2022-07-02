{ config
, options
, lib
, pkgs
, ...
}:
with lib;
with lib.my; let
  cfg = config.modules.develop.go;
  devCfg = config.modules.develop.xdg;
in
{
  options.modules.develop.go = {
    enable = mkBoolOpt false;
  };

  config = mkMerge [
    (mkIf cfg.enable {
      home.programs.go = {
        enable = true;
        packages = { };
        goPath = "go";
      };

      user.packages = with pkgs; [
        gopls
      ];
    })

    (mkIf devCfg.enable {
      # TODO:
    })
  ];
}
