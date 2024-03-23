{ pkgs, inputs, config, username, ... }:

{
  imports = [
    inputs.sops-nix.nixosModules.sops
    "${(import ./nix/sources.nix).sops-nix}/modules/sops"
  ];

  # Login PW

  sops.secrets.nixos-password.neededForUsers = true;

  users.users."${username}" = {
    isNormalUser = true;
    hashedPasswordFile = config.sops.secrets.nixos-password.path;
  };

  sops.age.keyFile = "/home/${username}/.config/sops/age/keys.txt";
  sops.defaultSopsFile = ../secrets/secrets.yaml;
  sops.defaultSopsFormat = "yaml";

  environment.systemPackages = with pkgs; [ sops age ];
}
