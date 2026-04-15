{ ... }:
{
  flake.nixosModules.pipewire =
    { lib, ... }:
    {
      config = {
        services.pipewire = {
          enable = lib.mkDefault true;
          pulse.enable = lib.mkDefault true;
          wireplumber.enable = lib.mkDefault true;
        };
      };
    };
}
