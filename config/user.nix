{ username, ... }:

{
  users = {
    users."${username}" = {
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" ];
      initialPassword = "asdf";
    };
    mutableUsers = false;
  };
}
