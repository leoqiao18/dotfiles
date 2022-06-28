{ pkgs, lib, ... }:
with lib;
with lib.my; let
  cfg = config.modules.hardware.nvidia;
in
{
  options.modules.hardware.nvidia = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    hardware.opengl.enable = true;
    services.xserver.videoDrivers = [ "nvidia" ];
  };
}
