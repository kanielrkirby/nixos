{ username, lib, config, ... }:

{
  home-manager.users."${username}" = { programs.atuin = { enable = true; }; };

  fileSystems."/home/${username}/.local/share/atuin" = {
    device = "/dev/zvol/zpool/atuin";
    fsType = "ext4";
  };
}
