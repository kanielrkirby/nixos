{ username, ... }:

{
  users = {
    users."${username}" = {
      isNormalUser = true;
      extraGroups = [ "wheel" "kvm" ];
      initialPassword = "asdf";
    };
    mutableUsers = false;
  };
}
