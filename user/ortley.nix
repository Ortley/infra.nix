{ config, ... }:
{
  sops.secrets."password/ortley".neededForUsers = true;
  
  users.users.ortley = {
    isNormalUser = true;
    hashedPasswordFile = config.sops.secrets."password/ortley".path;

    createHome = true;
    home = "/home/ortley";

    group = "users";
    extraGroups = [ "wheel" "networkmanager" "input" "win-drives" "notes" "i2c" ];
  };

  home-manager.users.ortley = { lib, pkgs, ...}: {
    home.stateVersion = lib.trivial.release;
    home.packages = with pkgs; [
      python315
    ];
  };
}
