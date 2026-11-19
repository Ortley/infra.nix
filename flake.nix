{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixos-26.05/nixexprs.tar.zst";
    nixpkgs-unstable.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.zst";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs: 
  let
    system = "x86_64-linux";
    hosts = [ 
      "mipha" "daruk" "revali" "urbosa" 
      "folkistan" "browntown" 
    ];
    mkHost = hostname: inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit hostname inputs; };
      modules = [
        inputs.home-manager.nixosModules.default {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
          };
        }
        ./module/default.nix
        ./host/${hostname}/configuration.nix
        ./host/${hostname}/hardware-configuration.nix
      ];
    };
  in
  {
    nixosConfigurations = inputs.nixpkgs.lib.genAttrs hosts mkHost;
  };
}
