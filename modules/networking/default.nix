{ config, options, lib, pkgs, ... }:
with lib;
with lib.my;
let
  cfg = config.modules.networking;
  configDir = "${config.dotfiles.configDir}";
in {
  options.modules.networking = {
    enable = mkBoolOpt false;
    networkManager.enable = mkBoolOpt false;
    networkd.enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable (mkMerge [
    {
      # Global useDHCP => deprecated.
      networking.useDHCP = false;
    }

    (mkIf cfg.networkManager.enable {
      # systemd.services.NetworkManager-wait-online.enable = false;

      networking.networkmanager = {
        enable = mkDefault true;
        # wifi.backend = "iwd";
      };

      user.extraGroups = [ "networkmanager" ];

      user.packages = with pkgs; [ networkmanager_dmenu ];

      home.configFile."networkmanager-dmenu" = {
        source = "${configDir}/networkmanager-dmenu";
        recursive = true;
      };
    })

    # TODO: add network connections + agenix.
    # (mkIf cfg.networkd.enable {
    #   systemd.network.enable = true;
    #
    #   systemd.services = {
    #     systemd-networkd-wait-online.enable = false;
    #     systemd-networkd.restartIfChanged = false;
    #     firewall.restartIfChanged = false;
    #   };
    #
    #   networking.interfaces = {
    #     enp1s0.useDHCP = true;
    #     wlan0.useDHCP = true;
    #   };
    # })
  ]);
}
