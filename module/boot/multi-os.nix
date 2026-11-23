{ ... }:
{
  imports = [ ./core.nix ];
  boot.loader = {
    grub = {
      useOSProber = true;
    };
    efi.canTouchEfiVariables = true;
  };
}
