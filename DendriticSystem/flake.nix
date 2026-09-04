{
  description = "Your new nix config";
  # Really do not want to lose link: https://codeberg.org/parrot/nixos-system-config/src/branch/master/hosts.nix
  # Also: https://blog.spacehey.com/entry?id=2107569
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    import-tree.url = "github:vic/import-tree";
    flake-parts.url = "github:hercules-ci/flake-parts";
    systems.url = "github:nix-systems/default";

    stylix.url = "github:nix-community/stylix/release-26.05";
    stylix.inputs.nixpkgs.follows = "nixpkgs";

    wallpaper-rs.url = "github:hambosto/wallpaper-rs";
  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } {
    imports = [
      inputs.flake-parts.flakeModules.modules
      
      ./hosts.nix
      (inputs.import-tree ./modules)
    ];

    systems = import inputs.systems;
  };
}