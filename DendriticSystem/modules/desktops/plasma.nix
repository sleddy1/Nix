{ self, ... }:
{
    flake.modules.nixos.desktops-plasma = {
        imports = with self.modules.nixos; [
            desktops-plasma-desktop
        ];
    };

    flake.modules.nixos.desktops-plasma-desktop = { pkgs, services, ... }: {
        services.desktopManager.plasma6.enable = true;
        # services.displayManager.sddm.enable = true;
    };

    # TODO: Setup Noctalia or some kind of bar
}