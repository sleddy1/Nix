{
    #TODO: Just for backwards compatability
    flake.modules.nixos.backwards = { pkgs, ... }: {
        environment.systemPackages = with pkgs; [
            wget
            wofi
            #nwg-look
        ];
    };
}