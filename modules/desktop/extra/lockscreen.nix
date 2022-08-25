{ options, config, lib, pkgs, ... }:
with lib;
with lib.my;
let cfg = config.modules.desktop.extra.lockscreen;
in {
  options.modules.desktop.extra.lockscreen = { enable = mkBoolOpt false; };

  config = mkIf cfg.enable {
    user.packages = with pkgs; [ i3lock xautolock xss-lock ];

    # xautolock to lock the screen (using i3lock) after 1 minute
    # (including a notification 10 seconds before actually locking the screen)
    #   ${getExe pkgs.xss-lock} -- ${getExe pkgs.i3lock} -c 2e3440 &

    # xss-lock to lock the screen on suspend (including keyboard hotkey)
    services.xserver.displayManager.sessionCommands = ''
      xset s off -dpms
      ${getExe pkgs.xautolock} -detectsleep -time 5 \
                -locker "systemctl suspend" \
                -notify 10 -notifier "${pkgs.libnotify}/bin/notify-send 'Suspending in 10 seconds'" &
      ${getExe pkgs.xss-lock} -- ${getExe pkgs.i3lock} -c 2e3440 &
    '';
  };
}
