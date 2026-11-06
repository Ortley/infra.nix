{ hostname, ... }:
{
  config.networking.hostName = hostname;
  config.system.stateVersion = "26.05";
}
