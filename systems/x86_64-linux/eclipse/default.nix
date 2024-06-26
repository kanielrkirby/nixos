{
  lib,
  config,
  ...
}: let
  inherit (lib.gearshift) enabled;
in {
  gearshift = {
    user = {
      enable = true;
      name = "mx";
    };

    dms.sddm = enabled;

    hardware = {
      battery = enabled;
      boot.fs.zfs = enabled;
      framework = enabled;
      pipewire = enabled;
      opengl = enabled;
    };

    nix.defaultSettings = enabled;

    network = {
      enable = true;
      firewall = enabled;
      hostId = "1736abc2";
    };

    programs = {
      developer = {
        lazysql = enabled;
        lsps = {
          bash = {
            bash_language_server = enabled;            
          };
          csharp = {
            netcoredbg = enabled;
            omnisharp = enabled;
          };
          css = {
            vscode_css_language_server = enabled;
          };
          docker = {
            docker_compose_language_service = enabled;
            docker_langserver = enabled;
          };
          go = {
            dlv = enabled;
            golangci_lint_langserver = enabled;
            gopls = enabled;
          };
          haskell = {
            haskell_language_server = enabled;
          };
          html = {
            vscode_html_languageserver = enabled;
          };
          json = {
            vscode_json_languageserver = enabled;
          };
          lldb_support = enabled;
          lua = {
            lua_language_server = enabled;
          };
          nix = {
            nil = enabled;
            alejandra = enabled;
          };
          protobuf = {
            bufls = enabled;
          };
          python = {
            python_language_server = enabled;
          };
          svelte = {
            svelte_language_server = enabled;
          };
          typescript = {
            prettier = enabled;
            typescript_language_server = enabled;
          };
          vue = {
            vue_language_server = enabled;
          };
          yaml = {
            yaml_language_server = enabled;
          };
        };
        virtualization = {
          kubernetes = enabled;
          libvirt = enabled;
          vagrant = enabled;
          podman = enabled;
        };
      };
      editors = {
        neovim = enabled;
        helix = enabled;
        # vscode = enabled;
      };
      gui = {
        browsers = {
          chromium = enabled;
          firefox = enabled;
          tor = enabled;
        };
        feh = enabled;
        foliate = enabled;
        hyprlock = enabled;
        hyprshade = enabled;
        launchers = {
          fuzzel = enabled;
        };
        libnotify = enabled;
        localsend = enabled;
        mpv = enabled;
        playerctl = enabled;
        signal = enabled;
        thunar = enabled;
        wallpaper = enabled;
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
        pass = enabled;
        # sops = enabled;
        ssh = enabled;
      };
      terminal = {
        emulators = {
          kitty = enabled;
          neovide = enabled;
        };
        rice = {
          oh-my-posh = enabled;
        };
        shells = {
          zsh = enabled;
        };
        tools = {
          age = enabled;
          bat = enabled;
          btop = enabled;
          eza = enabled;
          fd = enabled;
          findutils = enabled;
          fzf = enabled;
          gh = enabled;
          git = enabled;
          gnupg = enabled;
          httpie = enabled;
          # mods = enabled;
          # pop = enabled;
          rg = enabled;
          rip = enabled;
          sd = enabled;
          tealdeer = enabled;
          util-linux = enabled;
          coreutils = enabled;
          wget = enabled;
          yazi = enabled;
          zoxide = enabled;
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
    services = {
      dunst = enabled;
      mullvad-vpn = enabled;
      tlp = enabled;
      xserver = enabled;
    };
    themes = {
      catppuccin = enabled;
      gtk = enabled;
    };
    fonts = {
      monaspace = enabled;
      noto-sans = enabled;
    };
    wms.hyprland = enabled;
  };

  sound.enable = true;

  # disko.devices = {
  #   disk = {
  #     main = {
  #       type = "disk";
  #       device = "/dev/nvme0n1";
  #       content = {
  #         type = "gpt";
  #         partitions = {
  #           efi = {
  #             size = "1024M";
  #             type = "EF00";
  #             name = "efi";
  #             content = {
  #               type = "filesystem";
  #               format = "vfat";
  #               mountpoint = "/boot/efi";
  #             };
  #           };
  #           zfs = {
  #             size = "100%";
  #             content = {
  #               type = "zfs";
  #               pool = "zroot";
  #             };
  #           };
  #         };
  #       };
  #     };
  #   };
  #   zpool = {
  #     zroot = {
  #       type = "zpool";
  #       mountpoint = "/";
  #       rootFsOptions = {
  #         encryption = "on";
  #         keyformat = "passphrase";
  #         keylocation = "prompt";
  #         compression = "on";
  #         xattr = "sa";
  #         acltype = "posixacl";
  #       };
  #       options = {
  #         ashift = 12;
  #       };
  #       datasets = {
  #         nix = {
  #           type = "zfs_fs";
  #           mountpoint = "/nix";
  #         };
  #         home = {
  #           type = "zfs_fs";
  #           mountpoint = "/home";
  #         };
  #         var = {
  #           type = "zfs_fs";
  #           mountpoint = "/var";
  #         };
  #       };
  #     };
  #   };
  # };

  fileSystems = {
    "/" =
      { device = "zpool/root";
      fsType = "zfs";
    };

    "/etc" =
      { device = "zpool/etc";
      fsType = "zfs";
      neededForBoot = true;
    };

    "/var" =
      { device = "zpool/var";
      fsType = "zfs";
    };

    "/nix" =
      { device = "zpool/nix";
      fsType = "zfs";
    };

    "/nix/store" =
      { device = "/nix/store";
      fsType = "none";
      options = [ "bind" ];
    };

    "/home" =
      { device = "zpool/home";
      fsType = "zfs";
    };

    "/boot" =
      { device = "/dev/disk/by-uuid/8207-93D2";
      fsType = "vfat";
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

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.enableRedistributableFirmware = true;

  system.stateVersion = "24.11";
  home-manager.users.mx.home.stateVersion = "24.11";
}
