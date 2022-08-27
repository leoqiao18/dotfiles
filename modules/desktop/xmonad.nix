{ inputs, options, config, lib, pkgs, ... }:
with lib;
with lib.my;
let
  cfg = config.modules.desktop.xmonad;
  configDir = config.dotfiles.configDir;
in {
  options.modules.desktop.xmonad = { enable = mkBoolOpt false; };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      lightdm
      libnotify
      dunst
      pavucontrol
      playerctl
      gxmessage
      xdotool
      xclip
      feh
      arandr
      bc
      maim
      slop
    ];

    modules.desktop = {
      media.browser.nautilus.enable = true;
      extra = {
        arandr.enable = true;
        autorandr.enable = true;
        dbus.enable = true;
        dunst.enable = true;
        ibus.enable = true;
        lockscreen.enable = true;
        mimeApps.enable = true;
        picom.enable = true;
        rofi.enable = true;
        xkbOptions.enable = true;
        xmobar.enable = true;
      };
    };

    services.xserver = {
      enable = true;
      displayManager = {
        defaultSession = "none+xmonad";
        lightdm = {
          enable = true;
          greeters.mini.enable = true;
        };
        sessionCommands = ''
          ${getExe pkgs.autorandr} -c
        '';
      };
      windowManager.xmonad = {
        enable = true;
        enableContribAndExtras = true;
      };
    };

    services = {
      autorandr.enable = true;
      blueman.enable = true;
    };

    home.services = {
      gnome-keyring.enable = true;
      blueman-applet.enable = true;
      status-notifier-watcher.enable = true;
      network-manager-applet.enable = true;
    };

    home.configFile = {
      "xmonad" = {
        source = "${configDir}/xmonad";
        recursive = true;
      };
    };
    # home.xsession = {
    #   enable = true;
    #   numlock.enable = true;
    #   preferStatusNotifierItems = true;
    #   windowManager.command = "${getExe pkgs.haskellPackages.my-xmonad}";
    #   importedVariables = [ "GDK_PIXBUF_MODULE_FILE" ];
    # };
  };
}
