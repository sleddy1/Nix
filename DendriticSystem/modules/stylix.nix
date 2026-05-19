{
  pkgs,
  ...
}: 
{
    # TODO: Determine why stylix is not working
    flake.modules.nixos.stylixa = { pkgs, ... }: {
        stylix = {
            enable = true;
            autoEnable = true;
            base16Scheme = "${pkgs.base16-schemes}/share/themes/moonlight.yaml";

            image = pkgs.fetchurl {
                url = "https://getwallpapers.com/wallpaper/full/1/4/3/523784.jpg";
                hash = "sha256-S/6kgloXiIYI0NblT6YVXfqELApbdHGsuYe6S4JoQwQ=";
            };

            cursor = {
                package = pkgs.miku-cursor;
                name = "miku-cursor-linux";
                size = 16;
            };

            fonts = {
                monospace = {
                    package = pkgs.nerd-fonts.jetbrains-mono;
                    name = "JetBrainsMono Nerd Font";
                };
                sansSerif = {
                    package = pkgs.dejavu_fonts;
                    name = "DejaVu Sans";
                };
                serif = {
                    package = pkgs.dejavu_fonts;
                    name = "DejaVu Serif";
                };
            };
        };
    };
}