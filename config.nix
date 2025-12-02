{ config, lib, ... }:
let
  module = {
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
  nixosModules.config-module = module;
  homeModules.config-module = module;
}
