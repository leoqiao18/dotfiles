{ config
, options
, lib
, pkgs
, inputs
, ...
}:
with lib;
with lib.my; let
  cfg = config.modules.desktop.editors.neovim;
  nvimDir = "${config.dotfiles.configDir}/nvim";
  colorscheme = config.modules.themes.neovim.theme;
in
{
  options.modules.desktop.editors.neovim = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    nixpkgs.overlays = with inputs; [ neovim-nightly.overlay ];

    user.packages = with pkgs; [
      neovide
      neovim-nightly
      # (python3.withPackages (ps: with ps; [ pynvim ]))
    ];

    environment.shellAliases = {
      vi = "nvim";
      vim = "nvim";
      vimdiff = "nvim -d";
    };

    home.configFile."nvim" = {
      source = "${nvimDir}";
      recursive = true;
    };
  };
}
