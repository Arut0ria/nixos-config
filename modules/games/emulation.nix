{ pkgs
, config
, lib
, ...
}:
let
  cfg = config.emulation-module;
in
{
  options = {
    emulation-module.enable = lib.mkEnableOption "Enables emulation modules (retroarch, pcsx, ...)";
    emulation-module.retroarch.enable = lib.mkEnableOption "Enables retroarch.";
    emulation-module.pcsx2.enable = lib.mkEnableOption "Enables pcsx2.";
    emulation-module.rpcs3.enable = lib.mkEnableOption "Enables rpcs3.";
    emulation-module.ryubing.enable = lib.mkEnableOption "Enables ryubing (switch emulator).";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = lib.mkMerge (with pkgs; [
      (lib.optionals cfg.retroarch.enable [
        (retroarch.withCores (cores: with cores; [
          beetle-psx-hw
          beetle-psx
          citra
          snes9x2010
          nestopia
          picodrive
          desmume
        ]))
      ])
      (lib.optionals cfg.rpcs3.enable [ rpcs3 ])
      (lib.optionals cfg.pcsx2.enable [ pcsx2 ])
      (lib.optionals cfg.ryubing.enable [ ryubing ])
      [ melonDS ]
    ]);
  };
}
