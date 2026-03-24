{
  flake.modules.nixos.gaming = {
    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
    };
    programs.gamemode.enable = true;
    hardware.graphics.enable = true;
  };
}