{ options, config, lib, pkgs, ... }:
with lib;
with lib.my;
let
  cfg = config.modules.themes;
  deskCfg = config.modules.desktop;
  nord0 = "#2e3440";
  nord1 = "#3b4252";
  nord2 = "#434c5e";
  nord3 = "#4c566a";
  nord4 = "#d8dee9";
  nord5 = "#e5e9f0";
  nord6 = "#eceff4";
  nord7 = "#8fbcbb";
  nord8 = "#88c0d0";
  nord9 = "#81a1c1";
  nord10 = "#5e81ac";
  nord11 = "#bf616a";
  nord12 = "#d08770";
  nord13 = "#ebcb8b";
  nord14 = "#a3be8c";
  nord15 = "#b48ead";
in {
  config = mkIf (cfg.active == "nord") (mkMerge [
    {
      modules.themes = {
        wallpaper = mkDefault ./config/wallpaper.png;

        gtk = {
          theme = "Nordic";
          iconTheme = "Paper";
          cursor = {
            name = "Paper";
            size = 24;
          };
        };

        font = {
          sans.family = "Fira Sans";
          mono.family = "JetBrainsMono Nerd Font";
          emoji = "Twitter Color Emoji";
        };
        colors = {
          black = nord1;
          red = nord11;
          green = nord14;
          yellow = nord13;
          blue = nord9;
          magenta = nord15;
          cyan = nord8;
          white = nord5;

          brightBlack = nord3;
          brightRed = nord11;
          brightGreen = nord14;
          brightYellow = nord13;
          brightBlue = nord9;
          brightMagenta = nord15;
          brightCyan = nord7;
          brightWhite = nord6;

          types = {
            fg = nord4;
            bg = nord0;
            highlight = "#fffacd";
          };
        };
      };

      # modules.desktop.browsers = {
      #   firefox.userChrome = concatMapStringsSep "\n" readFile
      #     [ ./config/firefox/userChrome.css ];
      # };
    }

    # Desktop (X11) theming <- Change after gnome = independent of xserver.
    (mkIf config.services.xserver.enable {
      user.packages = with pkgs; [ nordic paper-icon-theme ];

      fonts.fonts = with pkgs; [
        # iosevka
        # fira-code
        # fira-code-symbols

        font-awesome
        fira
        twitter-color-emoji

        (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
      ];

      home.configFile = with deskCfg;
        mkMerge [{
          # Sourced from sessionCommands in modules/themes/default.nix
          "xtheme/90-theme".text = import ./config/Xresources cfg;
          # "fish/conf.d/catppuccin.fish".source =
          #   ./config/fish/catppuccin.fish;
        }
        # (mkIf (xmonad.enable || qtile.enable) {
        #   "dunst/dunstrc".text = import ./config/dunst/dunstrc cfg;
        #   "rofi" = {
        #     source = ./config/rofi;
        #     recursive = true;
        #   };
        # })
        # (mkIf terminal.alacritty.enable {
        #   "alacritty/config/catppuccin.yml".text =
        #     import ./config/alacritty/catppuccin.yml cfg;
        # })
        # (mkIf terminal.kitty.enable {
        #   "kitty/config/catppuccin.conf".text =
        #     import ./config/kitty/catppuccin.conf cfg;
        # })
        # (mkIf media.viewer.document.enable {
        #   "zathura/zathurarc".text = import ./config/zathura/zathurarc cfg;
        # })
        # (mkIf media.editor.vector.enable {
        #   "inkscape/templates/default.svg".source =
        #     ./config/inkscape/default-template.svg;
        # })
        ];
    })

    (mkIf (deskCfg.xmonad.enable || deskCfg.qtile.enable) {
      services.xserver.displayManager = {
        sessionCommands = with cfg.gtk; ''
          ${
            getExe pkgs.xorg.xsetroot
          } -xcf ${pkgs.paper-icon-theme}/share/icons/${cursor.name}/cursors/${cursor.default} ${
            toString (cursor.size)
          }
        '';

        # LightDM: Replace with LightDM-Web-Greeter theme
        lightdm.greeters.mini.extraConfig = ''
          font = "${cfg.font.mono.family}"
          font-size = 15px

          text-color = "${cfg.colors.types.fg}"
          error-color = "${cfg.colors.red}"
          password-color = "${cfg.colors.types.fg}"

          background-color = "${cfg.colors.types.bg}"
          password-background-color = "${cfg.colors.types.bg}"

          window-color = "${cfg.colors.types.bg}"
          border-color = "${cfg.colors.types.border}"

          border-width = 0
          password-border-width = 0
        '';
      };

      # # Fcitx5
      # home.file.".local/share/fcitx5/themes".source = pkgs.fetchFromGitHub {
      #   owner = "icy-thought";
      #   repo = "fcitx5-catppuccin";
      #   rev = "3b699870fb2806404e305fe34a3d2541d8ed5ef5";
      #   sha256 = "hOAcjgj6jDWtCGMs4Gd49sAAOsovGXm++TKU3NhZt8w=";
      # };
    })
  ]);
}
