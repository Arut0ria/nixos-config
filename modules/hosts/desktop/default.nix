{ self, inputs, ... }:
{
  flake.nixosConfigurations.nixos-desktop = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      inputs.home-manager.nixosModules.home-manager
      inputs.stylix.nixosModules.stylix
      inputs.lanzaboote.nixosModules.lanzaboote

      self.nixosModules.me-module
      self.nixosModules.nixos-desktop-configuration
      self.nixosModules.nixos-desktop-home
      self.nixosModules.nixos-desktop-hardware
    ];
  };
}
