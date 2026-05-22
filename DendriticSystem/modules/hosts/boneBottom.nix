{ self, ... }:
{
    flake.modules.nixos.hardware-pharloom = {
        imports = with self.modules.nixos; [
            hardware-common
            hardware-pharloom-disks
            hardware-pharloom-hardware
            hardware-pharloom-hardware
            hardware-pharloom-kernel
        ];
    };

    flake.modules.nixos.hardware-pharloom-disks = {
        fileSystems."/" =
            { 
                device = "/dev/disk/by-uuid/058da0c9-9e7d-4c79-8f3a-8652bbb5609b";
                fsType = "ext4";
            };

        fileSystems."/boot" =
            { 
                device = "/dev/disk/by-uuid/F2B8-D2B1";
                fsType = "vfat";
                options = [ "fmask=0022" "dmask=0022" ];
            };

        swapDevices = [ ];
    };

    flake.modules.nixos.hardware-pharloom-hardware = { lib, ... }: {
        imports = [ ];
        nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
        virtualisation.virtualbox.guest.enable = true;
    };

    flake.modules.nixos.hardware-pharloom-connectivity = {
        networking.hostName = "pharloom";
    };

    flake.modules.nixos.hardware-pharloom-kernel = {
        boot.initrd.availableKernelModules = [ "ata_piix" "ohci_pci" "ehci_pci" "ahci" "sd_mod" "sr_mod" ];
        boot.initrd.kernelModules = [ ];
        boot.kernelModules = [ "kvm-amd" ];
        boot.extraModulePackages = [ ];        
    };
}