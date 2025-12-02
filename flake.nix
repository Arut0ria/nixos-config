{
  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    getagal = {
      type = "git";
      url = "ssh://git@github.com/Arut0ria/getagal-rs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # kwin-effects-better_blur_dx = {
    #   url = "github:xarblu/kwin-effects-better-blur-dx";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    kwin-effects-forceblur = {
      url = "github:taj-ny/kwin-effects-forceblur/v1.3.6";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } (
      top@{ config
      , withSystem
      , moduleWithSystem
      , ...
      }:
      {
        debug = false;
        systems = [
          "x86_64-linux"
          "aarch64-linux"
        ];

        imports = [
          inputs.home-manager.flakeModules.home-manager

          ./nixos.nix
        ];
      }
    );
}
