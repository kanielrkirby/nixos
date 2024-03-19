{ username, lib, config, ... }:

{
  home-manager.users."${username}" = { programs.atuin = { enable = true; }; };

  fileSystems."/home/${username}/.local/share/atuin" = if builtins.elem "zfs" config.boot.supportedFilesystems then {
    device = "/dev/zvol/zpool/atuin";
    fsType = "ext4";
  } else {};
}
