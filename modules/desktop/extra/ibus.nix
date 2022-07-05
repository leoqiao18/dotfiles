{ options
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
    i18n.inputMethod = {
      enabled = "ibus";
      ibus.engines = with pkgs.ibus-engines; [
        libpinyin
      ];
    };

    environment.variables = mkMerge [
      {
        GTK_IM_MODULE = "ibus";
        QT_IM_MODULE = "ibus";
        XMODIFIERS = "@im=ibus";
        SDL_IM_MODULE = "ibus";
      }

      (mkIf cfg.terminal.kitty.enable {
        GLFW_IM_MODULE = "ibus";
      })
    ];

    services.xserver.displayManager.sessionCommands = ''
      ibus-daemon -d
    '';
  };
}
