{ config
, options
, lib
, pkgs
, ...
}:
with lib;
with lib.my; let
  cfg = config.modules.develop.cc;
  devCfg = config.modules.develop.xdg;
in
{
  options.modules.develop.cc = {
    enable = mkBoolOpt false;
  };

  config = mkMerge [
    (mkIf cfg.enable {
      user.packages = with pkgs; [
        gcc
        gdb
        gnumake
        cmake
        ccls
        bear
      ];
    })

    (mkIf devCfg.enable {
      # TODO:
    })
  ];
}
