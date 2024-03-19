{ username, ... }:

{
  users = {
    users."${username}" = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      initialPassword = "asdf";
    };
    mutableUsers = false;
  };
}
