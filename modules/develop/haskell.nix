{ config, options, lib, pkgs, ... }:
with lib;
with lib.my;
let
  cfg = config.modules.develop.haskell;
  devCfg = config.modules.develop.xdg;
  configDir = config.dotfiles.configDir;
in {
  options.modules.develop.haskell = { enable = mkBoolOpt false; };

  config = mkMerge [
    (mkIf cfg.enable {
      user.packages = with pkgs.haskellPackages; [
        brittany
        ormolu
        cabal-install
        cabal2nix
        ghc
        ghcide
        haskell-language-server
        hlint
        hoogle
        stack
        nix-tree
      ];

      home.configFile."brittany" = {
        source = "${configDir}/brittany";
        recursive = true;
      };
    })

    (mkIf devCfg.enable {
      # TODO:
    })
  ];
}
