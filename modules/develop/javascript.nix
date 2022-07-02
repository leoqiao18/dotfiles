{
  config,
  options,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.my; let
  cfg = config.modules.develop.javascript;
  devCfg = config.modules.develop.xdg;
in {
  options.modules.develop.javascript = {
    enable = mkBoolOpt false;
  };

  config = mkMerge [
    (mkIf cfg.enable {
      user.packages = with pkgs; [
        nodejs
        nodePackages.npm
        nodePackages.yarn
        nodePackages.eslint
        nodePackages.prettier
        nodePackages.typescript
        nodePackages.typescript-language-server
      ];
    })

    (mkIf devCfg.enable {
    })
  ];
}
