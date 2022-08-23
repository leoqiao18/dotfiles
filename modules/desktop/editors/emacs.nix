{ config, lib, pkgs, inputs, ... }:
with lib;
with lib.my;
let
  cfg = config.modules.desktop.editors.emacs;
  configDir = config.dotfiles.configDir;
in
{
  options.modules.desktop.editors.emacs = {
    enable = mkBoolOpt false;
    doom = {
      # enable = mkBoolOpt false;
      # forgeUrl = mkOpt types.str "https://github.com";
      # repoUrl = mkOpt types.str "${forgeUrl}/doomemacs/doomemacs";
      repoUrl = mkOpt types.str "https://github.com/doomemacs/doomemacs";
    };
  };

  config = mkIf cfg.enable {
    nixpkgs.overlays = with inputs; [ emacs.overlay ];

    home.services.emacs = {
      enable = true; # systemd Emacs service
      socketActivation.enable =
        true; # systemd socket activation for the Emacs service
      client.enable = true; # generation of Emacs client desktop file
    };

    home.programs.emacs = {
      enable = true;
      package = pkgs.emacsPgtkNativeComp;
      # extraPackages = epkgs: with epkgs; [ vterm pdf-tools org-pdftools ];
      extraPackages = epkgs: with epkgs; [ vterm ];
    };

    user.packages = with pkgs; [
      # Emacs itself
      binutils # native-comp needs 'as', provided by this
      # ((emacsPackagesFor emacsPgtkNativeComp).emacsWithPackages (epkgs: [
      #   epkgs.vterm
      # ]))

      # Doom dependencies
      git
      ripgrep
      gnutls

      # Optional dependencies
      fd
      imagemagick
      zstd

      # Module dependencies
      # checkers spell
      (aspellWithDicts (ds: with ds; [ en en-computers en-science ]))
      # :tools editorconfig
      editorconfig-core-c
      # :tools lookup & :lang org +roam
      sqlite
      # :lang latex & :lang ord (latex previews)
      texlive.combined.scheme-medium
    ];

    # Fonts -> icons + ligatures when specified:
    fonts.fonts = [ pkgs.emacs-all-the-icons-fonts ];

    # Enable access to doom (tool).
    env.PATH = [ "$XDG_CONFIG_HOME/emacs/bin" ];

    environment.variables = {
      EMACSDIR = "$XDG_CONFIG_HOME/emacs/";
      DOOMDIR = "$XDG_CONFIG_HOME/doom/";
    };

    home.configFile."doom" = {
      source = "${configDir}/doom";
      recursive = true;
      onChange = ''
        if [ ! -d "$XDG_CONFIG_HOME/emacs" ]; then
          git clone --depth=1 --single-branch "${cfg.doom.repoUrl}" "$XDG_CONFIG_HOME/emacs"
        fi
      '';
    };

    # system.userActivationScripts = mkIf cfg.doom.enable {
    #   installDoomEmacs = ''
    #     if [ ! -d "${config.user.home}/.config/emacs" ]; then
    #        ${pkgs.git} clone --depth=1 --single-branch "${cfg.doom.repoUrl}" "${config.user.home}/.config/emacs"
    #     fi
    #   '';
    # };

    # Easier frame creation (fish)
    # home.programs.fish.functions = {
    #   eg = "emacs --create-frame $argv & disown";
    #   ecg = "emacsclient --create-frame $argv & disown";
    # };
  };
}
