{ pkgs
, config
, lib
, ...
}:
{
  options = {
    emulation-module.enable = lib.mkEnableOption "Enables emulation modules (retroarch, pcsx, ...)";
    emulation-module.retroarch.enable = lib.mkEnableOption "Enables retroarch.";
    emulation-module.pcsx2.enable = lib.mkEnableOption "Enables pcsx2.";
    emulation-module.rpcs3.enable = lib.mkEnableOption "Enables rpcs3.";
    emulation-module.ryubing.enable = lib.mkEnableOption "Enables ryubing (switch emulator).";
  };

  config = lib.mkIf config.emulation-module.enable {
    environment.systemPackages = lib.mkMerge (with pkgs;[
      (lib.optionals (config.emulation-module.retroarch.enable) (retroarch.withCores (cores: with cores; [
        beetle-psx-hw
        beetle-psx
        citra
        snes9x2010
        nestopia
        picodrive
        desmume
      ])))
      (lib.optionals (config.emulation-module.rpcs3.enable) [ rpcs3 ])
      (lib.optionals (config.emulation-module.pcsx2.enable) [ pcsx2 ])
      (lib.optionals (config.emulation-module.ryubing.enable) [ ryubing ])
      [ melonDS ]
    ]);
  };
}
