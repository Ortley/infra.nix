{ hostname, ... }:
{
  imports = [
    ./user
    ./nix.nix
    ./sops.nix
  ];

  config.networking.hostName = hostname;
  config.system.stateVersion = "26.05";
}
