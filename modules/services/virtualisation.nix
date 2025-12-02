{ pkgs, config, lib, ... }:
let
  cfg = config.virtualisation-module;
in
{
  options = {
    virtualisation-module.enable = lib.mkEnableOption "Enables KVM, docker, qemu, etc. ";
    virtualisation-module.qemu.enable = lib.mkEnableOption "Enables qemu.";
    virtualisation-module.virtd.enable = lib.mkEnableOption "Enables virtd (manager and lib).";
    virtualisation-module.docker = {
      enable = lib.mkEnableOption "Enables docker.";
      settings = {
        storageDriver = lib.mkOption {
          type = lib.types.str;
          description = "Storage format used by the docker driver (same as disk container)";
          default = "btrfs";
        };
      };
    };
  };

  config = {
    /*
      Qemu and docker packages
    */
    environment.systemPackages = lib.mkMerge (with pkgs; [
      (lib.optionals cfg.qemu.enable [ qemu quickemu ])
      (lib.optionals cfg.docker.enable [ docker ])
    ]);

    virtualisation = {
      docker = lib.mkIf cfg.docker.enable {
        enable = true;
        storageDriver = cfg.docker.settings.storageDriver;
      };

      libvirtd.enable = cfg.virtd.enable;
    };

    programs.virt-manager.enable = cfg.virtd.enable;
  };
}
