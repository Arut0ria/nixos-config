{ ... }:
{
  flake.nixosModules.printing =
    { pkgs, ... }:
    {
      config = {
        services = {
          printing = {
            enable = true;
            drivers = with pkgs; [
              cups-filters
              cups-browsed
            ];
          };
        };
      };
    };
}
