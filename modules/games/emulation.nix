{
  ...
}:
{
  flake.nixosModules.emulation =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      options = {
        retroarch-enable = lib.mkOption {
          type = lib.types.bool;
          default = true;
        };

        pcsx2-enable = lib.mkOption {
          type = lib.types.bool;
          default = true;
        };

        rpcs3-enable = lib.mkOption {
          type = lib.types.bool;
          default = true;
        };

        ryubing-enable = lib.mkOption {
          type = lib.types.bool;
          default = true;
        };
      };

      config = {
        environment.systemPackages = lib.mkMerge (
          with pkgs;
          [
            (lib.optionals config.retroarch-enable [
              (retroarch.withCores (
                cores: with cores; [
                  beetle-psx-hw
                  beetle-psx
                  citra
                  snes9x2010
                  nestopia
                  picodrive
                  desmume
                ]
              ))
            ])
            (lib.optionals config.rpcs3-enable [ rpcs3 ])
            (lib.optionals config.pcsx2-enable [ pcsx2 ])
            (lib.optionals config.ryubing-enable [ ryubing ])
            [ melonDS ]
          ]
        );
      };
    };
}
