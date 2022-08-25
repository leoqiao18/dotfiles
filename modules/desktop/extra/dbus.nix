{ inputs, options, config, lib, pkgs, ... }:
with lib;
with lib.my;
let
  cfg = config.modules.desktop.extra.dbus;
  # configDir = config.dotfiles.configDir;
in {
  options.modules.desktop.extra.dbus = { enable = mkBoolOpt false; };

  config = mkIf cfg.enable { services.dbus = { enable = true; }; };
}
