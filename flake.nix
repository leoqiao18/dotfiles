{
  description = "λLeo.Qiao's NixOS system";

  inputs = {
    # primary nixpkgs
    nixpkgs.url = "nixpkgs/nixos-unstable";
    # unstable nixpkgs (added as nixpkgs.unstable below)
    nixpkgs-unstable.url = "nixpkgs/nixpkgs-unstable";

    # declarative user home
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # secret deployment (unused at the moment)
    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";

    # newest emacs (used in the emacs module)
    emacs.url = "github:nix-community/emacs-overlay";
    # newest neovim (used in the neovim module)
    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs =
    inputs @ { self
    , nixpkgs
    , nixpkgs-unstable
    , ...
    }:
    let
      inherit (lib.my) mapModules mapModulesRec mapHosts;
      system = "x86_64-linux";

      # helper: add overlays + unfree to pkgs argument
      mkPkgs = pkgs: extraOverlays:
        import pkgs {
          inherit system;
          config.allowUnfree = true;
          overlays = extraOverlays ++ (lib.attrValues self.overlays);
        };
      # this is the actual pkgs that will be used in the system
      # notice that self.overlay does these two things:
      # - pkgs.unstable -> pkgs'
      # - pkgs.my -> packages inside ./packages
      pkgs = mkPkgs nixpkgs [ self.overlay ];
      pkgs' = mkPkgs nixpkgs-unstable [ ];

      # extend lib with my own libs
      # this is also where pkgs gets into our system
      lib = nixpkgs.lib.extend (final: prev: {
        my = import ./lib {
          inherit pkgs inputs;
          lib = final;
        };
      });
    in
    {
      lib = lib.my;

      overlay = final: prev: {
        unstable = pkgs';
        my = self.packages."${system}";
      };

      overlays = mapModules ./overlays import;

      packages."${system}" = mapModules ./packages (p: pkgs.callPackage p { });

      nixosModules = {
        dotfiles = import ./.;
      } // mapModulesRec ./modules import;

      nixosConfigurations = mapHosts ./hosts { };

      # devShell."${system}" = import ./shell.nix { inherit pkgs; };

      # templates =
      #   {
      #     full = {
      #       path = ./.;
      #       description = "λLeo.Qiao's NixOS system";
      #     };
      #   }
      #   // import ./templates;
      # defaultTemplate = self.templates.full;

      # TODO: deployment + template tool.
      # defaultApp."${system}" = {
      #   type = "app";
      #   program = ./bin/hagel;
      # };
    };
}
