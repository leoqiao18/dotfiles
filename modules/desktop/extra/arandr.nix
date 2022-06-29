{ inputs
, options
, config
, lib
, pkgs
, ...
}:
with lib;
with lib.my; let
  cfg = config.modules.desktop;
in
{
  config = mkIf cfg.xmonad.enable {
    user.packages = with pkgs; [
      arandr
    ];
  };
}
