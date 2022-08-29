{ options, config, lib, pkgs, ... }:
with lib;
with lib.my;
let cfg = config.modules.shell;
in {
  options.modules.shell = {
    default = mkOption {
      type = with types; package;
      default = pkgs.bash;
      description = "Default system shell";
      example = "bash";
    };
  };

  config = mkIf (cfg.default != null) {
    users.defaultUserShell = cfg.default;

    user.packages = with pkgs; [
      any-nix-shell
      bat
      direnv
      fd
      fzf
      tldr
      xclip
      ripgrep
      zoxide
    ];

    home.services.lorri.enable = true;
  };
}
