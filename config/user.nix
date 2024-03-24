{ username, ... }:

{
  users = {
    users."${username}" = {
      isNormalUser = true;
      extraGroups = [ "wheel" "kvm" ];
    };
    mutableUsers = false;
  };
}
