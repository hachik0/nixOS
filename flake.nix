{
  description = "Default Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, ... } @ inputs:
  let
    system = "x86_64-linux";
    devPkgs = nixpkgs.legacyPackages."x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
      };
    };
  in
  {
    homeConfigurations."mitch" =
      inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
	modules = [ ./nixos/home.nix ];
	extraSpecialArgs = { inherit inputs; };
      };

    nixosConfigurations."mitch" =
      nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs system; };
        modules = [ ./configuration.nix ];
      };

      devShells."x86_64-linux".default =
        import ./shell.nix { inherit devPkgs; };
  };
}
