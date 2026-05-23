{
  pkgs,
  ...
}: 
{
    flake.modules.nixos.stylix = { pkgs, ... }: {
        stylix = {
            enable = true;
            autoEnable = true;
            base16Scheme = "${pkgs.base16-schemes}/share/themes/moonlight.yaml";

            image = pkgs.fetchurl {
                url = "https://getwallpapers.com/wallpaper/full/1/4/3/523784.jpg";
                hash = "sha256-S/6kgloXiIYI0NblT6YVXfqELApbdHGsuYe6S4JoQwQ=";
            };
            # cursor.package = pkgs.bibata-cursors;
            # cursor.name = "Bibata-Modern-Ice";
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