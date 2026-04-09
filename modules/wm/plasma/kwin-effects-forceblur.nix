{ inputs, ... }:
{

  flake.nixosModules.kwin-effects-forceblur-overlay =
    { pkgs, ... }:
    {
      config = {
        nixpkgs.overlays = [
          (final: prev: {
            kwin-effects-forceblur =
              inputs.kwin-effects-forceblur.packages.${final.stdenv.hostPlatform.system}.default;
          })
        ];

        environment.systemPackages = with pkgs; [ kwin-effects-forceblur ];
      };
    };
}
