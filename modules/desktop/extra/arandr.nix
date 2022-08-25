{ inputs, options, config, lib, pkgs, ... }:
with lib;
with lib.my;
let cfg = config.modules.desktop.extra.arandr;
in {
  options.modules.desktop.extra.arandr = { enable = mkBoolOpt false; };

  config = mkIf cfg.enable { user.packages = with pkgs; [ arandr ]; };
}
