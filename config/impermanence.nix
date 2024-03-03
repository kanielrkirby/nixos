{ username, impermanence }:

{
  imports = [
    "${impermanence}/nixos.nix"
  ];

  environment.persistence."/nix/persist/environment" = {
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
      "/etc/machine-id"
      "/etc/resolv.conf"
    ];
  };

  home-manager.users.mx = {
    imports = [
      "${impermanence}/home-manager.nix"
    ];

    home.persistence."/nix/persist/home" = {
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
        { directory = ".gnupg"; mode = "0700"; }
        { directory = ".ssh"; mode = "0700"; }
        ".config/BraveSoftware"
        ".config/Signal"
        ".config/gopass"
        { directory = ".config/password-store"; mode = "0700"; }
        ".local/share/direnv"
      ];
      files = [
        ".config/gh/hosts"
      ];
    };
  };
}
