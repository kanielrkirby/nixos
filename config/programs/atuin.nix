{ username, ... }:

{
  home-manager.users."${username}" = { programs.atuin = { enable = true; }; };

  fileSystems."/home/mx/.local/share/atuin" = {
    device = "/dev/zvol/zpool/atuin";
    fsType = "ext4";
  };
}
