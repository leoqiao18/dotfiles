{ options
, config
, lib
, pkgs
, ...
}:
with lib;
with lib.my; let
  cfg = config.modules.desktop.browsers.firefox;
in
{
  options.modules.desktop.browsers.firefox = with types; {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    home.programs.firefox.enable = true;
  };
}
