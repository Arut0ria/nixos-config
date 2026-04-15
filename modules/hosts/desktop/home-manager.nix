{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.nixos-desktop-home =
    {
      pkgs,
      config,
      lib,
      ...
    }:
    let
      inherit (config) me;
    in
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;

        sharedModules = [
          inputs.plasma-manager.homeModules.plasma-manager
          inputs.nixvim.homeModules.nixvim
        ];

        users.${me.username} = {
          home = {
            username = "${me.username}";
            homeDirectory = "/home/${me.username}";
            stateVersion = "25.11";
          };

          imports = with self.homeModules; [
            me-module

            btop
            cava
            fastfetch
            ranger
            mangohud
            discord
            firefox
            kitty-config
          ];
        };
      };
    };
}
