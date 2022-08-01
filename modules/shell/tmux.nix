{ config, options, lib, pkgs, ... }:
with lib;
with lib.my;
let
  cfg = config.modules.shell.tmux;
  term = config.modules.desktop.terminal;
  tmuxDir = "${config.dotfiles.configDir}/tmux";
in {
  options.modules.shell.tmux = { enable = mkBoolOpt false; };

  config = mkIf (cfg.enable || term.kitty.enable) {
    user.packages = with pkgs; [ tmux tmuxinator ];

    home.configFile."tmux" = {
      source = "${tmuxDir}";
      recursive = true;
      onChange = ''
        if [ ! -d "$XDG_CONFIG_HOME/tmux/plugins/tpm" ]; then
          git clone https://github.com/tmux-plugins/tpm "$XDG_CONFIG_HOME/tmux/plugins/tpm"
        fi
      '';
    };
  };
}
