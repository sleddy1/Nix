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
                device = "/dev/disk/by-uuid/afc0760b-10de-431b-9941-187723287181";
                fsType = "ext4";
            };

        fileSystems."/boot" =
            { 
                device = "/dev/disk/by-uuid/C1B2-0527";
                fsType = "vfat";
                options = [ "fmask=0077" "dmask=0077" ];
            };

        swapDevices = 
          [ { device = "/dev/disk/by-uuid/0d1b5e4e-9c0a-4162-a420-e2086fc05524"; }
          ];
    };

    flake.modules.nixos.hardware-pharloom-hardware = { config, lib, modulesPath, ... }: {
        imports = 
          [ (modulesPath + "/installer/scan/not-detected.nix") 
          ];
        nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
        hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
        hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
        hardware.nvidia.open = true;
        services.xserver.videoDrivers = [ "nvidia" ];
	hardware.nvidia.modesetting.enable = true;
        hardware.graphics.enable = true;
    };

    flake.modules.nixos.hardware-pharloom-connectivity = {
        networking.hostName = "pharloom";
    };

    flake.modules.nixos.hardware-pharloom-kernel = {
        boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" ];
        boot.initrd.kernelModules = [ ];
        boot.kernelModules = [ "kvm-amd" ];
        boot.extraModulePackages = [ ];        
    };
}
