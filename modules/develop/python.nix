{ config
, options
, lib
, pkgs
, ...
}:
with lib;
with lib.my; let
  cfg = config.modules.develop.python;
  devCfg = config.modules.develop.xdg;
in
{
  options.modules.develop.python = {
    enable = mkBoolOpt false;
  };

  config = mkMerge [
    (mkIf cfg.enable {
      user.packages = with pkgs; [
        python3
        python3Packages.pip
        python3Packages.black
        python3Packages.pylint
        nodePackages.pyright
      ];
    })

    (mkIf devCfg.enable { })
  ];
}
