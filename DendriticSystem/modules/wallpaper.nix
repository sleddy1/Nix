{ inputs, pkgs, ... }: {
    flake.modules.homeManager.wallpaper-rs = {inputs, pkgs, ...}: {
        imports = [ inputs.wallpaper-rs.homeManagerModules.default ];
        services.wallpaper-rs = {
            enable = true;
            image = pkgs.fetchurl {
                url = "https://w.wallhaven.cc/full/zp/wallhaven-zpq1dg.jpg";
                hash = "sha256-DVQcpz2JpOfFFMhOfMFH6iMHrrAkafAbIZ5GcOgjNJc=";
            };
        };
    };
}