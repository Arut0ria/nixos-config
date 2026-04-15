{ inputs, self, ... }:
{
  flake.nixosModules.nixos-vm-configuration =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    let
      inherit (config) me;
    in
    {

      nix.settings = {
        experimental-features = "nix-command flakes";
      };

      boot = {
        kernelPackages = pkgs.linuxPackages_zen;
        kernelParams = [
          "quiet" # TRÈS IMPORTANT : Cache les logs de démarrage pour laisser la place à Plymouth
          "splash" # Force l'affichage de l'écran de splash
          "nvidia-drm.modeset=1"
          "boot.shell_on_fail" # Pratique en cas de plantage pour avoir un shell
          "plymouth.debug" # Garde-le le temps de tester
          "udev.log_level=3"
          "systemd.show_status=auto"
          "plymouth.ignore-serial-consoles"
        ];

        consoleLogLevel = 3; # Augmente la verbosité
        initrd = {
          systemd.enable = true;
          verbose = false;
          # availableKernelModules = [
          #   "virtio_pci"
          #   "virtio_scsi"
          #   "ahci"
          #   "usbhid"
          #   "sd_mod"
          # ];

          kernelModules = [
            "virtio_gpu"
            "qxl"
            "vmwgfx"
            "vboxvideo"
            # "cirrus"
          ];
        };

        loader = {
          systemd-boot.enable = true;
          efi.canTouchEfiVariables = true;
        };

        plymouth = {
          enable = true;
          theme = lib.mkForce "evangelion-ui";
          themePackages = with pkgs; [
            # By default we would install all themes
            (adi1090x-plymouth-themes.override {
              selected_themes = [ "rings" ];
            })
            inputs.evangelion-ui.packages.${pkgs.stdenv.hostPlatform.system}.evangelion-ui
          ];
          extraConfig = ''
            [Daemon]
            ShowDelay=0
            DeviceTimeout=8
          '';
        };
      };

      virtualisation = {
        vmVariant = {
          # following configuration is added only when building VM with build-vm
          virtualisation = {
            memorySize = 2048; # Use 2048MiB memory.
            cores = 4;
            graphics = true;
          };
        };
      };

      services.openssh = {
        enable = true;
        settings.PasswordAuthentication = true;
      };

      services.qemuGuest.enable = true;
      services.spice-vdagentd.enable = true;

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
        (with self.packages.${pkgs.stdenv.hostPlatform.system}; [
          getagal
        ])
        # (with pkgs; [ kitty ])
        (with self.packages.${pkgs.stdenv.hostPlatform.system}; [
          (zsh.wrap {
            zsh-getagal-pattern = "(?i).*(bath).*\.(jpe?g|png|gif|bmp|webp)$";
          })
          neovim
        ])
        #   (import ../common_packages.nix { inherit pkgs; })
      ];

      nixpkgs.hostPlatform = "x86_64-linux";
      # nixpkgs.allowUnfree = true;
      system.stateVersion = "25.11";

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

      stylix = {
        # enable = lib.mkForce false;
        fonts.sizes.applications = lib.mkForce 8;
        fonts.sizes.terminal = lib.mkForce 8;
      };

      imports = [
        self.nixosModules.stylix-base-config
        self.nixosModules.stylix-font-config
        self.nixosModules.stylix-plasma-config

        self.nixosModules.kwin-effects-forceblur-overlay
        self.nixosModules.plasma-kde-config

        self.nixosModules.french-locale

        # self.nixosModules.plasma-module
        # self.nixosModules.fr-locale-module
        # self.nixosModules.services-module
        # self.nixosModules.stylix-plasma-config
      ];

      # Overrides
      # stylix-plasma-config.fontSize = lib.mkForce 10;
    };
}
