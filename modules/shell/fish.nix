{ config, options, lib, pkgs, ... }:
with lib;
with lib.my;
let
  cfg = config.modules.shell;
  configDir = "${config.dotfiles.configDir}";
  fishCfg = "${config.dotfiles.configDir}/fish";
in {
  options.modules.shell.fish = { enable = mkBoolOpt false; };

  config = mkIf cfg.fish.enable {
    programs.fish.enable = true;

    modules.shell.starship.enable = true;

    # fix for command-not-found not supported anymore on unstable
    home.programs.command-not-found.enable = false;
    home.programs.nix-index = {
      enable = true;
      enableFishIntegration = true;
    };

    home.programs.fish = {
      enable = true;
      interactiveShellInit = ''
        ${getExe pkgs.starship} init fish | source
        ${getExe pkgs.zoxide} init fish | source
        ${getExe pkgs.any-nix-shell} fish | source

        ${builtins.readFile "${fishCfg}/interactive.fish"}
        ${builtins.readFile "${fishCfg}/abbreviations/git.fish"}
      '';
    };

    # home.configFile."fish" = {
    #   source = "${configDir}/fish";
    #   recursive = true;
    # };
  };
}
