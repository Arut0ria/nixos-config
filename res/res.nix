{ pkgs, ... }:
let
  res = pkgs.stdenv.mkDerivation {
    name = "resources";
    src = ./.;
    dontUnpack = true;
    installPhase = ''
      mkdir -p $out/res
      cp -r $src/* $out/res/
    '';
  };
in
res
