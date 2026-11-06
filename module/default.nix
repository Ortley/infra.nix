{ hostname, ... }:
{
  imports = [
    ./user
  ];

  config.networking.hostName = hostname;
  config.system.stateVersion = "26.05";
}
