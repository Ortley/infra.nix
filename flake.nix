{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixos-26.05/nixexprs.tar.zst";
    nixpkgs-unstable.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.zst";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix"; 
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs: 
  let
    lib = inputs.nixpkgs.lib;

    system = "x86_64-linux";
    hosts = [ 
      "mipha" "daruk"# "revali" "urbosa" 
      "browntown" #"folkistan"  
    ];

    userModules = 
      lib.mapAttrsToList (name: _: ./user + "/${name}")
        (lib.filterAttrs
          (name: type: type == "regular" && lib.hasSuffix ".nix" name)
          (builtins.readDir ./user));

    mkHost = hostname: lib.nixosSystem {
      inherit system;
      specialArgs = { inherit hostname inputs; };
      modules = [
        ./module/default.nix
        ./host/${hostname}/configuration.nix
        ./host/${hostname}/hardware-configuration.nix
        inputs.disko.nixosModules.disko
        inputs.sops-nix.nixosModules.sops
        inputs.home-manager.nixosModules.default {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = { inherit inputs; };
            backupFileExtension = "bak";
          };
        }
      ] ++ userModules;
    };
  in
  {
    nixosConfigurations = inputs.nixpkgs.lib.genAttrs hosts mkHost;
  };
}
