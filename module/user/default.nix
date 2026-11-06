{ config, lib, ... }:
let
  uids = import ./uids.nix;
  gids = import ./gids.nix;
in {
  users.groups = lib.mapAttrs(name: gid: {
    inherit gid;
    inherit name;
  }) gids;

  users.users = lib.mapAttrs (_name: uid: {
    inherit uid;
    enable = lib.mkDefault false;
  }) uids;

  # All defined normal users that are missing from uids.nix
  assertions = [{
    assertion = lib.all (n: uids ? ${n}) (builtins.attrNames
      (lib.filterAttrs (_: u: u.isNormalUser) config.users.users));
    message = "! Every normal user must have an entry in modules/user/uids.nix";
  }];
}
