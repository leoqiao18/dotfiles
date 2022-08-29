{ config, options, lib, pkgs, ... }:
with lib;
with lib.my;
let
  cfg = config.modules.shell;
  zshCfg = "${config.dotfiles.configDir}/zsh";
in {
  options.modules.shell.zsh = { enable = mkBoolOpt false; };

  config = mkIf cfg.zsh.enable {
    programs.zsh.enable = true;

    home.programs.zsh = {
      enable = true;
      enableCompletion = true;
      enableSyntaxHighlighting = true;
      shellAliases = {

      } // mkIf config.programs.tmux.enable { mux = "tmuxinator"; };
      # history = {
      #   size = 10000;
      #   path = "${config.xdg.dataHome}/zsh/history";
      # };
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" ];
        theme = "robbyrussell";
      };
      initExtra = ''
        eval "$(direnv hook zsh)"
        any-nix-shell zsh --info-right | source /dev/stdin
      '';
    };
  };
}
