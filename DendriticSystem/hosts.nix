{ inputs, self, config, ... }:
{
  flake.nixosConfigurations.pharloom = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs; };
    modules = [
      self.modules.nixos.pharloom
    ];
  };

  flake.modules.nixos.pharloom.imports = with self.modules.nixos; [
    ly
    gaming
    shell
    nixos
    hardware-pharloom
    desktops-niri
    backwards

    users-scott
  ] ++ [
    inputs.home-manager.nixosModules.default
    {
      home-manager.users.scott = {
        imports = with self.modules.homeManager; [
            users-scott
            shell
        ];
      };
    }
  ];
}