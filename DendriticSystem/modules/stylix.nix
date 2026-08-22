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

            # Figure out resolution issues
            image = 
            builtins.path {
                path = ../modules/assets/wallhaven-6d3zkl.jpg;
            };
            #pkgs.fetchurl {
            #    url = "https://w.wallhaven.cc/full/6d/wallhaven-6dpllw.png";
            #    hash = "sha256-E9c/R3acUif7SpWA0ItsbNETarjHlD8lsenhdBespMI=";
            #};
            
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