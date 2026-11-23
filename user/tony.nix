{ config, ... }:
{
  sops.secrets."password/tony".neededForUsers = true;
  
  users.users.tony = {
    isNormalUser = true;
    hashedPasswordFile = config.sops.secrets."password/tony".path;

    createHome = true;
    home = "/home/tony";

    group = "users";
    extraGroups = [ "wheel" "networkmanager" ];
  };

  home-manager.users.tony = { lib, pkgs, ...}: {
    home.stateVersion = lib.trivial.release;
  };
}
