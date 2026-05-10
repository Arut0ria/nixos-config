{ ... }:
{
  flake.nixosModules.avahi =
    { pkgs, ... }:
    {
      config = {
        services = {
          avahi = {
            enable = true;
            nssmdns4 = true;
            openFirewall = true;
          };
        };
      };
    };
}
