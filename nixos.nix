{ withSystem
, moduleWithSystem
, inputs
, ...
}:
let
  generateConfig = ({ sysName, sysConfig, pkgsAttr ? { } }:
    withSystem sysName ({ pkgsConfig, ... }: inputs.nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        # Nixpkgs
        inputs.nixpkgs.nixosModules.readOnlyPkgs
        (
          let
            pkgs = import inputs.nixpkgs {
              inherit (inputs.nixpkgs.lib.recursiveUpdate pkgsConfig pkgsAttr) system overlays config;
            };
          in
          { nixpkgs.pkgs = pkgs; }
        )

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
    {
      _module.args.pkgsConfig = {
        inherit system;

        # Overlays
        overlays = [
          (final: prev: { getagal = inputs.getagal.packages.${final.stdenv.hostPlatform.system}.default; })
          (final: prev: { kwin-effects-forceblur = inputs.kwin-effects-forceblur.packages.${final.stdenv.hostPlatform.system}.default; })
          (final: prev: { res = (import ./res/res.nix { inherit (final) pkgs; }); })
        ];

        config = {
          allowUnfree = true;
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
      nixosConfigurations.nixos-desktop = generateConfig {
        sysName = "x86_64-linux";
        
        sysConfig = [
          currentModules.config-module
          ./hosts/desktop/configuration.nix
        ];

        pkgsAttr = {
          config.cudaSupport = true;
          config.cudaVersion = "12";
          config.nvidia.acceptLicense = true;
        };
      };

      nixosConfigurations.nixos-laptop = generateConfig {
        sysName = "x86_64-linux";

        sysConfig = [
          currentModules.config-module
          ./hosts/laptop/configuration.nix
        ];
      };

      nixosConfigurations.nixos-vm = generateConfig {
        sysName = "x86_64-linux";
        sysConfig = [
          currentModules.config-module
          ./hosts/vm/configuration.nix
        ];
      };
    };
}
