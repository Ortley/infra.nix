{ config, ... }:
{
  sops.secrets."password/bossman".neededForUsers = true;
  
  users.users.bossman = {
    isNormalUser = true;
    hashedPasswordFile = config.sops.secrets."password/bossman".path;

    createHome = true;
    home = "/home/bossman";

    group = "users";
    extraGroups = [ "networkmanager" ];
  };

  home-manager.users.bossman = { lib, pkgs, ...}: {
    home.stateVersion = lib.trivial.release;
  };
}
