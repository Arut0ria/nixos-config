{ config, lib, pkgs, inputs, ... }:
let
  inherit (inputs) self;
  inherit (self) nixosModules;
  inherit (config) me;
in
{
  nix.settings = {
    experimental-features = "nix-command flakes";
  };

  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  virtualisation.vmVariant = {
    # following configuration is added only when building VM with build-vm
    virtualisation = {
      memorySize = 2048; # Use 2048MiB memory.
      cores = 3;
      graphics = true;
    };
  };

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = true;
  };

  networking = {
    firewall = {
      enable = true;
      allowedTCPPorts = [
        22
      ];
    };
    hostName = "nixos-vm";
  };

  environment.systemPackages = lib.mkMerge [
    (with pkgs; [
      getagal
      kwin-effects-forceblur
    ])
    (import ../common_packages.nix { inherit pkgs; })
  ];

  # nixpkgs.hostPlatform = "x86_64-linux";
  system.stateVersion = "25.05";

  users.users = {
    ${me.username} = {
      isNormalUser = true;
      initialPassword = "theo";
      extraGroups = [
        "wheel"
        "docker"
        "libvirtd"
      ];

      shell = pkgs.zsh;
      ignoreShellProgramCheck = true;
    };
  };

  imports = [
    nixosModules.plasma-module
    nixosModules.fr-locale-module
    nixosModules.services-module
    nixosModules.stylix-plasma-config

    ./home-manager.nix
  ];

  # Overrides
  stylix-plasma-config.fontSize = lib.mkForce 10;
}
