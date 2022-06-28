{ inputs
, options
, config
, lib
, pkgs
, ...
}:
with lib;
with lib.my; let
  cfg = config.modules.desktop.xmonad;
  configDir = config.dotfiles.configDir;
in
{
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      haskellPackages.xmobar
    ];

    home.configFile = {
      "xmobar" = {
        source = "${configDir}/xmobar";
        recursive = true;
      };
    };
  };
}
