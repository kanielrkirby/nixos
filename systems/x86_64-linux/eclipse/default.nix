{
  lib,
  config,
  ...
}: let
  inherit (lib.gearshift) enabled;
in {
  gearshift = {
    user.name = "mx";
    dms.sddm = enabled;

    hardware = {
      battery = enabled;
      boot.fs.zfs = enabled;
      framework = enabled;
      pipewire = enabled;
      opengl = enabled;
    };

    services = {
      tlp = enabled;
      mullvad-vpn = enabled;
    };

    wms.hyprland = enabled;

    network = {
      enable = true;
      firewall = enabled;
    };

    nix.defaultSettings = enabled;

    programs = {
      editors = {
        neovim = enabled;
      };
      gui = {
        feh = enabled;
        foliate = enabled;
        hyprshade = enabled;
        libnotify = enabled;
        mpv = enabled;
        playerctl = enabled;
        thunar = enabled;
        wallpaper = enabled;
        browsers = {
          chromium = enabled;
          firefox = enabled;
          tor = enabled;
        };
        localsend = enabled;
        signal = enabled;
      };
      nix = {
        comma = enabled;
        up = enabled;
        nd = enabled;
        ns = enabled;
        nh = enabled;
      };
      security = {
        gnupg = enabled;
        sops = enabled;
        ssh = enabled;
      };
      terminal = {
        shells = {
          zsh = enabled;
        };
        tools = {
          age = enabled;
          curl = enabled;
          diffutils = enabled;
          fd = enabled;
          findutils = enabled;
          gnupg = enabled;
          httpie = enabled;
          mods = enabled;
          pop = enabled;
          rg = enabled;
          rip = enabled;
          sd = enabled;
          util-linux = enabled;
          coreutils = enabled;
          wget = enabled;
        };
      };
      wayland = {
        grim = enabled;
        slurp = enabled;
        swappy = enabled;
        wl-screenrec = enabled;
        wl-clipboard = enabled;
        ydotool = enabled;
      };
    };
  };

  sound.enable = true;

  networking.hostId = "1736abc2";

  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/nvme0n1";
        content = {
          type = "gpt";
          partitions = {
            efi = {
              size = "1024M";
              type = "EF00";
              name = "efi";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "zroot";
              };
            };
          };
        };
      };
    };
    zpool = {
      zroot = {
        type = "zpool";
        mountpoint = "/";
        rootFsOptions = {
          encryption = "on";
          keyformat = "passphrase";
          keylocation = "prompt";
          compression = "on";
          xattr = "sa";
          acltype = "posixacl";
        };
        options = {
          ashift = 12;
        };
        datasets = {
          nix = {
            type = "zfs_fs";
            mountpoint = "/nix";
          };
          home = {
            type = "zfs_fs";
            mountpoint = "/home";
          };
          var = {
            type = "zfs_fs";
            mountpoint = "/var";
          };
        };
      };
    };
  };

  boot = {
    initrd = {
      availableKernelModules = [ "xhci_pci" "thunderbolt" "nvme" ];
      kernelModules = [ ];
    };
    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];
  };

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
