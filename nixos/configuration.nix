{ config, lib, pkgs, pkgs-unstable, inputs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.home-manager
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "pharloom";

  networking.networkmanager.enable = true;

  time.timeZone = "America/Phoenix";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  virtualisation.virtualbox.guest.enable = true;

  services.openssh.enable = true;

  programs.firefox.enable = true;

  nixpkgs.config.allowUnfree = true;

  services.xserver.enable = true;
  services.displayManager.ly = {
    enable = true;
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      scott = import ../home-manager/home.nix;
    };
  };

  programs.niri.enable = true;
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
  };
  security.polkit.enable = true;
  services.dbus.enable = true;

  hardware.graphics.enable = true;

  programs.steam.enable = true;

  programs.starship.enable = true;

  # fonts = {
  #   enableDefaultPackages = true;
  #   fontconfig.enable = true;
  #   packages = with pkgs-unstable; [
  #     nerd-fonts.jetbrains-mono
  #   ];
  # };

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

  users.groups.scott = {};
  users.users.scott = {
    isNormalUser = true;
    group = "scott";
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      firefox
      curl
      wget
      git
      vim
    ];
  };

  environment.systemPackages = with pkgs; [
    firefox
    curl
    wget
    git
    vim
    niri
    #kitty
    #waybar
    wofi
    nwg-look
    vscode
    #fuzzel
    xwayland-satellite
    fastfetch
    discord
    mako
 ];

  # Enable sound.
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Do Not Touch
  system.stateVersion = "25.11";
}

