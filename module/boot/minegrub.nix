{ pkgs, ... }:
{
  imports = [ ./core.nix ];
  boot.loader.grub.theme = pkgs.stdenv.mkDerivation {
    pname = "minegrub-world-sel-theme";
    version = "0.1";
    src = pkgs.fetchFromGitHub {
      owner = "Lxtharia";
      repo = "minegrub-world-sel-theme";
    };

    installPhase = ''
      cp -r $src/minegrub-world-selection $out
    '';
  };
}
