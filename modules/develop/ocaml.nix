{ config
, options
, lib
, pkgs
, ...
}:
with lib;
with lib.my; let
  cfg = config.modules.develop.ocaml;
  devCfg = config.modules.develop.xdg;
in
{
  options.modules.develop.ocaml = {
    enable = mkBoolOpt false;
  };

  config = mkMerge [
    (mkIf cfg.enable {
      user.packages = with pkgs; [
        ocamlPackages.ocaml
        ocamlPackages.ocaml-lsp
        ocamlformat
        opam
      ];
    })

    (mkIf devCfg.enable {
      # TODO:
    })
  ];
}
