{ self, inputs, ... }:
{
  flake.nixosConfigurations.nixos-laptop = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      inputs.home-manager.nixosModules.home-manager
      inputs.stylix.nixosModules.stylix
      inputs.lanzaboote.nixosModules.lanzaboote

      self.nixosModules.me-module
      self.nixosModules.nixos-laptop-configuration
      self.nixosModules.nixos-laptop-home
      self.nixosModules.nixos-laptop-hardware
    ];
  };
}
