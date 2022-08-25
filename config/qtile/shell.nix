{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  nativeBuildInputs = with pkgs; [ nodePackages.pyright ];
  buildInputs = [ pkgs.qtile ];
}
