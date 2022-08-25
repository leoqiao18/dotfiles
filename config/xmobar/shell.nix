{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  nativeBuildInputs = with pkgs; [ haskell-language-server ];
  buildInputs = with pkgs;
    [ (haskellPackages.ghcWithPackages (ps: with ps; [ xmobar ])) ];
}
