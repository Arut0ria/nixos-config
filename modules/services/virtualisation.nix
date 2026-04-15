{
  ...
}:
{
  flake.nixosModules.virtualisation =
    {
      pkgs,
      lib,
      ...
    }:
    {

      config = {
        # Qemu and docker packages
        environment.systemPackages = with pkgs; [
          qemu
          quickemu
          docker
        ];

        virtualisation = {
          docker = {
            enable = lib.mkDefault true;
            storageDriver = lib.mkDefault "btrfs";
          };

          libvirtd.enable = lib.mkDefault true;
        };

        programs.virt-manager.enable = lib.mkDefault true;
      };
    };
}
