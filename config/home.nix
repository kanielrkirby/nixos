{ inputs, username, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    useGlobalPkgs = true;

    users."${username}" = {
      home.stateVersion = "23.11";
    };
  };
}
