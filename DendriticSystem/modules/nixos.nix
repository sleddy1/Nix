{ self, ... }:
{
    flake.modules.nixos.nixos = {
        imports = with self.modules.nixos; [
            nixos-essentials
            # TODO: determine if we want this
            # nixos-tooling
        ];
    };

    flake.modules.nixos.nixos-essentials = { pkgs, ... }: {
        programs.nix-ld.enable = true;

        nixpkgs.config.allowUnfree = true;

        nix.settings.experimental-features = [ "nix-command" "flakes" ];
        nix.settings.trusted-users = [ "root" "scott" ];

        # Do Not Touch
        system.stateVersion = "25.11";
    };

    flake.modules.nixos.nixos-tooling = {
        programs.nh = {
            enable = true;
            clean = {
                enable = true;
                dates = "hourly";
                extraArgs = "--keep 5";
            };
            flake = "/home/scott/Nix/DendriticSystem";
        };
    };
}