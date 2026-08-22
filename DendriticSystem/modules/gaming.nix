{
  flake.modules.nixos.gaming = {
    programs.steam = {
      enable = true;
      gamescopeSession = {
        enable = true;
        args = [ "--hdr-enabled" ];
      };
    };
    programs.gamemode.enable = true;
    hardware.graphics.enable = true;
  };
}

# {
#   flake.modules.nixos.gaming = { pkgs, ... }: {

#     programs.steam = {
#       enable = true;

#       gamescopeSession = {
#         enable = true; 

#         # HDR + NVIDIA-safe flags
#         args = [
#           "--hdr-enabled"
#           "--adaptive-sync"
#           "--rt"
#         ];

#         env = {
#           ENABLE_HDR_WSI = "1";
#           PROTON_ENABLE_WAYLAND = "1";
#           PROTON_ENABLE_HDR = "1";
#         };
#       };
#     };

#     programs.gamemode.enable = true;
#     environment.sessionVariables = {
#       ENABLE_HDR_WSI = "1";
#       PROTON_ENABLE_HDR = "1";
#       PROTON_ENABLE_WAYLAND = "1";
#     };
#   };
# }