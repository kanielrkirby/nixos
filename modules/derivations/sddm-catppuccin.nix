{ pkgs, ... }:

pkgs.stdenv.mkDerivation {
  name = "sddm-catppuccin";
  src = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "sddm";
    rev = "f3db13cbe8e99a4ee7379a4e766bc8a4c2c6c3dd";
    sha256 = "sha256-0zoJOTFjQq3gm5i3xCRbyk781kB7BqcWWNrrIkWf2Xk=";
  };
  installPhase = ''
    mkdir -p $out
    cp -R ./* $out/
  '';
}
