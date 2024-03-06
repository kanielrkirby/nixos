{ username, impermanence, ... }:

{
  imports = [
    impermanence.nixosModules.impermanence
  ];

  programs.fuse.userAllowOther = true;

  environment.persistence."/persist" = {
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/var/lib/libvirt"
      "/var/lib/containers"
      "/etc/NetworkManager/system-connections"
      "/etc/mullvad-vpn"
    ];
    files = [
#      "/etc/machine-id"
#      "/etc/passwd"
#      "/etc/shadow"
    ];
  };

  home-manager.users."${username}" = {
    imports = [
      impermanence.nixosModules.home-manager.impermanence
    ];

    home.persistence."/persist/home/${username}" = {
      allowOther = true;
      directories = [
        "Downloads"
        "Pictures"
        "Documents"
        ".builds"
        ".codeium"
        ".hyprland"
        ".vscode"
        "dev"
        ".config/BraveSoftware"
        ".config/Signal"
        ".config/gopass"
        ".local/share/direnv"
        { directory = ".gnupg"; }
        { directory = ".ssh"; }
        { directory = ".config/password-store"; }
      ];
      files = [
        ".config/gh/hosts"
      ];
    };
  };
}
