{ pkgs
, config
, lib
, ...
}: {
  imports = [ ./hardware-configuration.nix ];

  modules = {
    hardware = {
      audio.enable = true;
      bluetooth.enable = true;
      logitech.enable = true;
    };

    networking = {
      enable = true;
      networkManager.enable = true;
    };

    themes.active = "catppuccin";

    desktop = {
      xmonad.enable = true;
      terminal = {
        default = "kitty";
        kitty.enable = true;
      };
      editors = {
        default = "nvim";
        # neovim.agasaya.enable = true;
      };
      browsers = {
        default = "chromium";
        # brave.enable = true;
        firefox.enable = true;
        chromium.enable = true;
      };
      media = {
        social = {
          common.enable = true;
        };
        viewer = {
          # video.enable = true;
          music.enable = true;
          # document.enable = true;
        };
      };
      # virtual.wine.enable = true;
    };

    develop = {
      haskell.enable = true;
      python.enable = true;
      rust.enable = true;
    };

    # containers.transmission = {
    #   enable = false; # TODO: Once fixed -> enable = true;
    #   username = "alonzo";
    #   password = builtins.readFile config.age.secrets.torBylon.path;
    # };

    # services = {
    #   # ssh.enable = true;
    #   kdeconnect.enable = true;
    # };

    shell = {
      default = pkgs.zsh;
      git.enable = true;
      zsh.enable = true;
      # fish.enable = true;
      # gnupg.enable = true;
    };
  };

  services = {
    upower.enable = true;
    printing.enable = true;

    # xserver = {
    #   videoDrivers = ["amdgpu"];
    #   deviceSection = ''
    #     Option "TearFree" "true"
    #   '';
    #   libinput.touchpad = {
    #     accelSpeed = "0.5";
    #     accelProfile = "adaptive";
    #   };
    # };
  };
}
