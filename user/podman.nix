{ pkgs, ... }:
{
  users.users.podman = {
    name = "podman";
    description = "Rootless Podman service user";

    isNormalUser = true;

    createHome = true;
    home = "/home/podman";

    group = "podman";
    extraGroups = [ "sshaccess" "music" ];

    shell = pkgs.bash;
    linger = true;

    autoSubUidGidRange = true;
  };

  virtualisation.podman = {
    enable = true;
    extraPackages = [ pkgs.bash ];
    #daemon.settings.data-root = "/home/podman/.local/share/docker";
  };
}
