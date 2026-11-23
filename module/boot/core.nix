{ ... }:
{
  boot.loader = {
    timeout = 15;
    grub = {
      enable = true;
      device = "nodev";
    };
  };
}
