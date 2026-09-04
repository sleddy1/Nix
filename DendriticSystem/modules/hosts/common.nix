{ self, ... }:
{
  flake.modules.nixos.hardware-common = {
    imports = with self.modules.nixos; [
      hardware-common-bootloader-limine
      #hardware-common-kernel
      hardware-common-timezone
      hardware-common-connectivity
      # hardware-common-syncthing
      hardware-common-sound
      hardware-common-bluetooth
    ];
  };

  flake.modules.nixos.hardware-common-bootloader = {
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.systemd-boot.extraEntries."windows.conf" = ''
      title Windows
      efi /EFI/Microsoft/Boot/bootmgfw.efi
    '';
  };

  flake.modules.nixos.hardware-common-bootloader-limine = { pkgs, ... }: {
    boot.loader.limine = {
      enable = true;
      secureBoot.enable = true;
      maxGenerations = 10;
      #TODO: Switch from extra entries once this is supported
      #resolution = "5120x1440"; 
      style.interface.resolution = "5120x1440";
      extraEntries = ''
        /Windows
          protocol: efi
          path: uuid(ac293d4e-58c3-11ee-98b2-e45e37011cbe):/EFI/Microsoft/Boot/bootmgfw.efi
        resolution = 5120x1440
      '';
    };
    boot.loader.efi.canTouchEfiVariables = true;
    environment.systemPackages = [ pkgs.sbctl ];
  };

  flake.modules.nixos.hardware-common-connectivity = {
    networking.networkmanager.enable = true;
    # TODO: Tossing stuff here to be lazy, figure out where it goes in the future
    services.openssh.enable = true;
    security.polkit.enable = true;
    services.dbus.enable = true;
  };

  flake.modules.nixos.hardware-common-kernel = { pkgs, ... }: {
    boot.kernelPackages = pkgs.linuxPackages_latest;
  };

  flake.modules.nixos.hardware-common-timezone = {
    services.tzupdate.enable = true;
  };

  flake.modules.nixos.hardware-common-syncthing = {
    services.syncthing.enable = true;
  };

  flake.modules.nixos.hardware-common-sound = {
    services.pipewire = {
      enable = true;
      pulse.enable = true;
    };
  };

  flake.modules.nixos.hardware-common-bluetooth = {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };
}
