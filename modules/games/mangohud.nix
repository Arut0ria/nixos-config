{ config, lib, ... }: {
  options = {
    mangohud-module.enable = lib.mkEnableOption "Enables mangohud";

    mangohud-module.displayBattery = lib.mkOption {
      type = lib.types.bool;
      description = "Define if mangohud should show battery info.";
      default = false;
    };
  };

  config = lib.mkIf config.mangohud-module.enable {
    programs.mangohud = {
      enable = true;
      settings = {
        # fsr_steam_sharpness = 5;
        # nis_steam_sharpness = 10;
        # full = true;
        cpu_temp = true;
        gpu_temp = true;
        ram = true;
        vram = true;
        io_read = true;
        io_write = true;
        arch = true;
        gpu_name = true;
        cpu_power = true;
        gpu_power = true;
        wine = true;
        frametime = true;
        battery = config.mangohud-module.displayBattery;
        font_scale = lib.mkForce 1;
      };
    };
  };
}