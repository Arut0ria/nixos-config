{ config, lib, pkgs, inputs, ... }:
let
  inherit (inputs) self;
  inherit (self) nixosModules;
  inherit (config) me;
in
{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix

      # Modules
      nixosModules.plasma-module
      nixosModules.fr-locale-module
      nixosModules.services-module
      nixosModules.virtualisation-module
      nixosModules.nvidia-module
      nixosModules.games-module
      nixosModules.stylix-plasma-config

      (import ../fonts.nix { inherit pkgs lib; })

      # Home-Manager
      ./home-manager.nix
    ];

  nix.settings = {
    experimental-features = [ "nix-command flakes" ];
  };

  # Boot config
  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    loader = {
      # No systemd-boot lanzaboote takes precedence
      # systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 10;
    };

    supportedFilesystems = [
      "btrfs"
      "vfat"
      "ntfs"
    ];

    initrd.systemd.enable = true;

    lanzaboote = lib.mkIf (builtins.hasAttr "lanzaboote" config.boot) {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
    };
  };

  # Network config
  networking = {
    firewall = {
      enable = true;
      allowedTCPPorts = [
        22
      ];
    };
    networkmanager.enable = true;
    hostName = "nixos-desktop";
  };

  # Packages
  environment.systemPackages = lib.mkMerge [
    (with pkgs; [
      getagal
      kwin-effects-forceblur
    ])
    (import ../common_packages.nix { inherit pkgs; })
  ];

  # Users
  programs.zsh.enable = true;
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
    };
  };

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = true;
  };

  programs = {
    ssh.startAgent = true;
  };

  security.polkit.enable = true;

  system.stateVersion = "25.11";
}
