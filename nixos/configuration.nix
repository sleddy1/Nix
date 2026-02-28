{ config, lib, pkgs, inputs, ... }:

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

  # stylix ={
  #   enable = true;
  #   base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
  # };

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
    alacritty
    waybar
    wofi
    nwg-look
    vscode
    fuzzel
    xwayland-satellite
    fastfetch
 ];

  # Enable sound.
  # services.pipewire = {
  #   enable = true;
  #   pulse.enable = true;
  # };

  # Do Not Touch
  system.stateVersion = "25.11";
}

