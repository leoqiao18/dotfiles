{ config
, options
, lib
, pkgs
, ...
}:
with lib;
with lib.my; let
  cfg = config.modules.desktop.browsers.chromium;
in
{
  options.modules.desktop.browsers.chromium = {
    enable = mkBoolOpt false;
  };

  config = mkIf cfg.enable {
    home.programs.chromium = {
      enable = true;
      # package = pkgs.ungoogled-chromium;
      # extensions = [
      #   {
      #     id = "ocaahdebbfolfmndjeplogmgcagdmblk";
      #     updateUrl = "https://raw.githubusercontent.com/NeverDecaf/chromium-web-store/master/updates.xml";
      #   }
      #   { id = "jhnleheckmknfcgijgkadoemagpecfol"; } # Auto-Tab-Discard
      #   { id = "nngceckbapebfimnlniiiahkandclblb"; } # Bitwarden
      #   { id = "eimadpbcbfnmbkopoojfekhnkhdbieeh"; } # Dark-Reader
      #   { id = "ldpochfccmkkmhdbclfhpagapcfdljkj"; } # Decentraleyes
      #   { id = "bkdgflcldnnnapblkhphbgpggdiikppg"; } # DuckDuckGo
      #   { id = "gphhapmejobijbbhgpjhcjognlahblep"; } # Gnome-Shell-Integration
      #   { id = "iaiomicjabeggjcfkbimgmglanimpnae"; } # Tab-Session-Manager
      #   { id = "hipekcciheckooncpjeljhnekcoolahp"; } # Tabliss
      #   { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # Ublock-Origin
      #   {
      #     id = "dcpihecpambacapedldabdbpakmachpb";
      #     updateUrl = "https://raw.githubusercontent.com/iamadamdev/bypass-paywalls-chrome/master/updates.xml";
      #   }
      # ];
    };
  };
}
