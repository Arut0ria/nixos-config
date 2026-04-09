{ ... }:
let
  module =
    { lib, ... }:
    {
      options = {
        me = lib.mkOption {
          type = lib.types.submodule {
            options = {
              username = lib.mkOption { type = lib.types.str; };
            };
          };
        };
      };

      config = {
        me = {
          username = "theo";
        };
      };
    };
in
{
  flake.nixosModules.me-module = module;
  flake.homeModules.me-module = module;
}
