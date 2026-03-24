{ self, ... }:
{
    flake.modules.nixos.shell = {
        imports = with self.modules.nixos; [
            shell-essentials
            shell-kitty
        ];
    };

    flake.modules.homeManager.shell = {
        imports = with self.modules.homeManager; [
            shell-kitty
            shell-prompt
        ];
    };

    flake.modules.nixos.shell-essentials = { pkgs, ... }: {
        environment.systemPackages = with pkgs; [
            vim
            curl
            git
            ffmpeg
            yt-dlp
        ];
    };

    flake.modules.nixos.shell-kitty = { pkgs, ... }: {
        environment.systemPackages = with pkgs; [
            kitty
        ];
        # programs.kitty.enable = true;
    };

    flake.modules.homeManager.shell-kitty = {
        programs.kitty.enable = true;
        # TODO: Get rid of prompt to close
    };

    flake.modules.homeManager.shell-prompt = {
        programs.starship.enable = true;
        # TODO: Rip config file here, need to find newline one:
        programs.starship.settings = builtins.fromTOML ''
        
        '';
    };
}