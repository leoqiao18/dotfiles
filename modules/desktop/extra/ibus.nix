{ options, config, lib, pkgs, ... }:
with lib;
with lib.my;
let cfg = config.modules.desktop.extra.ibus;
in {
  options.modules.desktop.extra.ibus = { enable = mkBoolOpt false; };

  config = mkIf cfg.enable {
    i18n.inputMethod = {
      enabled = "ibus";
      ibus.engines = with pkgs.ibus-engines; [ libpinyin ];
    };

    environment.variables = mkMerge [{
      GTK_IM_MODULE = "ibus";
      QT_IM_MODULE = "ibus";
      XMODIFIERS = "@im=ibus";
      SDL_IM_MODULE = "ibus";
    }];

    systemd.user.services.ibus = {
      description = "ibus: input method framework for multilingual input";
      wantedBy = [ "graphical-session.target" ];
      partOf = [ "graphical-session.target" ];

      serviceConfig = {
        Type = "forking";
        ExecStart = "${config.i18n.inputMethod.package}/bin/ibus-daemon -d";
        ExecStop = "pkill ibus-daemon";
        Restart = "on-failure";
      };
    };

    # services.xserver.displayManager.sessionCommands = ''
    #   ibus-daemon -d
    # '';
  };
}
