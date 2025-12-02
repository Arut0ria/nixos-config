{ lib, ... }:
let
  baseModules = {
    dlna-module = {
      imports = [
        ./dlna.nix
      ];

      config.dlna-module.enable = lib.mkDefault true;
    };

    pipewire-module = {
      imports = [
        ./pipewire.nix
      ];

      config.pipewire-module.enable = lib.mkDefault true;
    };

    virtualisation-module = {
      imports = [
        ./virtualisation.nix
      ];

      config.virtualisation-module = {
        enable = lib.mkDefault true;
        qemu.enable = lib.mkDefault true;
        virtd.enable = lib.mkDefault true;
        docker.enable = lib.mkDefault true;
      };
    };
  };

  services-module.imports = builtins.attrValues baseModules;
in
{
  nixosModules = baseModules // {
    inherit services-module;
  };
}
