{ self, ... }:
{
    flake.modules.nixos.desktops-niri = {
        imports = with self.modules.nixos; [
            desktops-niri-desktop
        ];
    };

    flake.modules.nixos.desktops-niri-desktop = { pkgs, ... }: {
        programs.niri.enable = true;
        environment.systemPackages = with pkgs; [
            xwayland-satellite
            mako
        ];

        environment.sessionVariables = {
            NIXOS_OZONE_WL = "1";
            ELECTRON_OZONE_PLATFORM_HINT = "auto";
        };
    };

    # TODO: Setup Noctalia or some kind of bar
}