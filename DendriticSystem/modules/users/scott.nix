{ self, ... }:
{
    flake.modules.nixos.users-scott = {
        imports = with self.modules.nixos; [
            users-scott-essentials
        ];
    };

    flake.modules.homeManager.users-scott = {
        imports = with self.modules.homeManager; [
            users-scott-essentials
            users-scott-apps
            users-scott-git
        ];
    };

    flake.modules.nixos.users-scott-essentials = {
        users.users.scott = {
            isNormalUser = true;
            extraGroups = [ "networkmanager" "wheel" ];
        };
    };

    flake.modules.homeManager.users-scott-essentials = {
        programs.home-manager.enable = true;
        home.stateVersion = "25.11";
        home.username = "scott";
        home.homeDirectory = "/home/scott";
        nixpkgs.config.allowUnfree = true;
        # Workaround for https://github.com/nix-community/home-manager/issues/2942
        nixpkgs.config.allowUnfreePredicate = _: true;
        # TODO: Determine placement
        systemd.user.startServices = "sd-switch";
    };

    flake.modules.homeManager.users-scott-git = {
        programs.git = {
            enable = true;
            settings = {
                user.email = "scott.ledyard1@gmail.com";
                user.name = "scott";
                push.autoSetupRemote = true;
                pull.rebase = true;
            };
        };
    };

    flake.modules.homeManager.users-scott-apps = {pkgs, ... }: {
        programs.fuzzel.enable = true;
        programs.waybar.enable = true;
        programs.anki.enable = true;

        # TODO: Investigate stylix and how it applies across modularity
        # stylix.targets.kitty.enable = true;
        # stylix.targets.vscode.enable = true;
        
        home.packages = with pkgs; [
            firefox
            vscode
            discord
            fastfetch
            fuzzel
            # TODO: Maybe clean below
            curl
            wget
            vim
        ];
    };
}