{ self, ... }:
{
    flake.modules.nixos.hardware-bone-bottom = {
        imports = with self.modules.nixos; [
            hardware-common
            hardware-bone-bottom-disks
            hardware-bone-bottom-hardware
            hardware-bone-bottom-hardware
            hardware-bone-bottom-kernel
        ];
    };

    flake.modules.nixos.hardware-bone-bottom-disks = {
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

    flake.modules.nixos.hardware-bone-bottom-hardware = { lib, ... }: {
        imports = [ ];
        nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
        virtualisation.virtualbox.guest.enable = true;
    };

    flake.modules.nixos.hardware-bone-bottom-connectivity = {
        networking.hostName = "bone-bottom";
    };

    flake.modules.nixos.hardware-bone-bottom-kernel = {
        boot.initrd.availableKernelModules = [ "ata_piix" "ohci_pci" "ehci_pci" "ahci" "sd_mod" "sr_mod" ];
        boot.initrd.kernelModules = [ ];
        boot.kernelModules = [ "kvm-amd" ];
        boot.extraModulePackages = [ ];        
    };
}