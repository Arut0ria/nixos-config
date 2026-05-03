{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.nixos-desktop-configuration =
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
      imports = with self.nixosModules; [
        # Modules
        stylix-base-config
        stylix-font-config
        stylix-plasma-config

        kwin-effects-forceblur-overlay
        plasma-kde-config

        french-locale

        dlna
        pipewire
        virtualisation
        devenv

        caching
        nvidia-config

        emulation
        game-packages
        steam

        ai-module
      ];

      nix.settings = {
        experimental-features = [ "nix-command flakes" ];
      };

      # Boot config
      boot = {
        kernelPackages = pkgs.linuxPackages_zen;
        kernelModules = [ "kvm-amd" ];
        kernelParams = [
          "nvidia-drm.fbdev=1"
          # "NVreg_EnableGpuFirmware=0"
        ];

        extraModulePackages = [ ];

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

        initrd = {
          systemd.enable = true;
          kernelModules = [ ];
          availableKernelModules = [
            "nvme"
            "xhci_pci"
            "ahci"
            "usb_storage"
            "usbhid"
            "sd_mod"
          ];
        };

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
        (with self.packages.${pkgs.stdenv.hostPlatform.system}; [
          getagal
          zsh
          neovim
        ])

        (with pkgs; [
          git
          wget
          vlc
          blender
          nh
          p7zip
          rar
          htop
          libreoffice
          tree
          imagemagick

          sbctl

          tty-clock
          deluge
          playerctl

          vulkan-tools
          wineWowPackages.stable
          winetricks
          wineWowPackages.waylandFull

          gimp
          inkscape
          easyeffects
          lmms
          vital

          wl-clipboard
        ])
      ];

      # Adding nerd fonts for icons
      fonts.packages =
        [ ] ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);

      # Users
      programs.zsh.enable = true;
      environment.pathsToLink = [ "/share/zsh" ];

      users.users = {
        ${me.username} = {
          isNormalUser = true;
          initialPassword = "theo";
          extraGroups = [
            "wheel"
            "docker"
            "libvirtd"
          ];

          shell = self.packages.${pkgs.stdenv.hostPlatform.system}.zsh;
          ignoreShellProgramCheck = true;
        };
      };

      services.openssh = {
        enable = true;
        settings.PasswordAuthentication = true;
      };

      programs = {
        ssh.startAgent = true;
        kdeconnect.enable = true;
      };

      security.polkit.enable = true;

      stylix.fonts.sizes.applications = lib.mkForce 13;

      nixpkgs.hostPlatform = "x86_64-linux";
      nixpkgs.config.allowUnfree = true;
      system.stateVersion = "25.11";
    };
}
