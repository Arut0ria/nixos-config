{ ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      packages.ressources = pkgs.stdenv.mkDerivation {
        name = "ressouces";
        src = ./.;
        dontUnpack = true;
        installPhase = ''
          mkdir -p $out/share
          cp -r $src/share/* $out/share
        '';
      };
    };
}
