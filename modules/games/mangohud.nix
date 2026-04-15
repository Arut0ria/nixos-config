{ ... }:
{
  flake.homeModules.mangohud =
    {
      lib,
      ...
    }:
    {
      config = {
        programs.mangohud = {
          enable = lib.mkDefault true;
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
            battery = lib.mkDefault false;
            font_scale = lib.mkForce 1;
            fps_limit = "60,90,120,30";
          };
        };
      };
    };
}

