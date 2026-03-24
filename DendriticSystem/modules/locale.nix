{self, ... }:
{
    flake.modules.nixos.locale = {
        imports = with self.modules.nixos; [
        ];
    };
}