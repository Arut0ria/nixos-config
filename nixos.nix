{ withSystem
, moduleWithSystem
, inputs
, ...
}:
let
  generateConfig = (sysName: sysConfig:
    withSystem sysName ({ pkgs, ... }: inputs.nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        # Nixpkgs
        inputs.nixpkgs.nixosModules.readOnlyPkgs
        { nixpkgs.pkgs = pkgs; }

        # Home manager
        inputs.home-manager.nixosModules.home-manager

        # Top level modules
        inputs.lanzaboote.nixosModules.lanzaboote

        # Stylix setup
        { stylix.overlays.enable = false; }
        inputs.stylix.nixosModules.stylix
      ] ++ sysConfig;
    }
    ));
in
{
  perSystem =
    { system, lib, config, ... }:
    # let
    #   stylix-overlays = import (builtins.toPath "${inputs.stylix.outPath}/stylix/autoload.nix") { inherit lib; } "overlay";
    # in
    {
      _module.args.pkgs = import inputs.nixpkgs {
        inherit system;

        # Overlays
        overlays = [
          (final: prev: { getagal = inputs.getagal.packages.${final.system}.default; })
          (final: prev: { kwin-effects-forceblur = inputs.kwin-effects-forceblur.packages.${final.system}.default; })
          (final: prev: { res = (import ./res/res.nix { inherit (final) pkgs; }); })
        ];

        config = {
          allowUnfree = true;
          nvidia.acceptLicense = true;
        };
      };
    };

  flake =
    let
      currentModules = inputs.self.nixosModules;
    in
    {
      # Loading modules at top level
      imports = [
        ./config.nix
      ] ++ (import ./modules/modules.nix {
        inherit (inputs.nixpkgs) lib;
      });

      # Defining configs
      nixosConfigurations.nixos-desktop = generateConfig "x86_64-linux" [
        currentModules.config-module
        ./hosts/desktop/configuration.nix
      ];

      nixosConfigurations.nixos-vm = generateConfig "x86_64-linux" [
        currentModules.config-module
        ./hosts/vm/configuration.nix
      ];
    };
}
