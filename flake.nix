{
    description = "Nixos config flake";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

        nvf = {
            url = "github:notashelf/nvf";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        hyprland = {
            url = "github:hyprwm/Hyprland";
        };

    };
# , nix-matlab
    outputs = { self, nvf,  home-manager, nixpkgs, ... }@inputs: 
        let
            system = "x86_64-linux";
            pkgs = nixpkgs.legacyPackages.${system};
        in
            {
            nixosConfigurations = {
                laptop = nixpkgs.lib.nixosSystem {
                    specialArgs = {inherit inputs;};
                    modules = [
                        nvf.nixosModules.default
                        ./hosts/laptop/configuration.nix
                        # flake-overlays
                        inputs.home-manager.nixosModules.default

                        home-manager.nixosModules.home-manager 
                        {
                            home-manager.useGlobalPkgs = true;
                            home-manager.useUserPackages = true;
                            home-manager.extraSpecialArgs = {inherit inputs;};
                            home-manager.users.myUser = import ./hosts/laptop/home.nix;
                            home-manager.sharedModules = [
                                {
                                    wayland.windowManager.hyprland = {
                                        enable = true;
                                        package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
                                        portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
                                    };
            }
                            ];
                        }
                    ];
                };
            };
        };
}
