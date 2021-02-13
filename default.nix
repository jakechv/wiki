{ pkgs ? import <nixpkgs> { } }:

let
  haskellDeps = ps:
    with ps; [
      base
      lens
      mtl
      aeson
      hlint
      haskell-language-server
      time
      brittany
      turtle
    ];
  ghc = pkgs.haskellPackages.ghcWithPackages haskellDeps;
  nixPackages = [ ghc pkgs.gdb pkgs.haskellPackages.cabal-install ];
in pkgs.stdenv.mkDerivation {
  name = "Wiki";
  src = pkgs.lib.cleanSource ./.;
  preferLocalBuild = true;
  buildInputs = nixPackages;
}
