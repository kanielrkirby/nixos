{ inputs, pkgs, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  users = {
    defaultUserShell = pkgs.zsh;
    users.mx = {
      isNormalUser = true;
      extraGroups = [ "wheel" "libvirtd" ];
    };
  };

#  qt = {
#    enable = true;
#    platformTheme = "gtk2";
#    style = "gtk2";
#  };

  home-manager = {
    useGlobalPkgs = true;

    users.mx = { pkgs, ... }: {
      home.stateVersion = "23.11";

#      gtk = {
#        enable = true;
#        theme = {
#          package = pkgs.fluent-gtk-theme;
#          name = "Fluent-GTK";
#        };
#
#        iconTheme = {
#          package = pkgs.fluent-icon-theme;
#          name = "Fluent";
#        };
#
#        font = {
#          name = "Noto Sans";
#          size = 14;
#        };
#      };

      gtk = {
        enable = true;
        theme = {
          package = pkgs.flat-remix-gtk;
          name = "Flat-Remix-GTK-Grey-Darkest";
        };

        iconTheme = {
          package = pkgs.gnome.adwaita-icon-theme;
          name = "Adwaita";
        };

        font = {
          name = "Sans";
          size = 12;
        };
      };

      dconf.settings = {
        "org/virt-manager/virt-manager/connections" = {
          autoconnect = ["qemu:///system"];
          uris = ["qemu:///system"];
        };
      };

      home.packages = with pkgs; [
        git
        httpie
        nodejs
        wl-clipboard
        fw-ectool
        grim
        slurp
        ripgrep
        hyprpaper
        hyprshade
        signal-desktop
        brightnessctl
        playerctl
        libnotify
        glib
      ];

      programs.less.enable = true;

      programs.zsh = {
        enable = true; 
        enableAutosuggestions = true;
        syntaxHighlighting.enable = true;
        enableCompletion = true;
        profileExtra = ''
          export LANG="en_US.UTF-8"
          export LC_ALL="$LANG"
          export ANKI_WAYLAND="1"
          alias svim="sudo -E -s nvim"
        '';
      };

      programs.starship = {
        enable = true;
        enableZshIntegration = true;
        settings = {
          format=''$username$hostname$localip$shlvl$singularity$kubernetes$directory$vcsh$fossil_branch$git_branch$git_commit$git_state$git_metrics$git_status$hg_branch$pijul_channel$docker_context$package$c$cmake$cobol$daml$dart$deno$dotnet$elixir$elm$erlang$fennel$golang$guix_shell$haskell$haxe$helm$java$julia$kotlin$gradle$lua$nim$nodejs$ocaml$opa$perl$php$pulumi$purescript$python$raku$rlang$red$ruby$rust$scala$solidity$swift$terraform$vlang$vagrant$zig$buf$nix_shell$conda$meson$spack$memory_usage$aws$gcloud$openstack$azure$env_var$crystal$custom$sudo$cmd_duration$line_break$jobs$battery$time$status$os$container$shell$character'';
          scan_timeout = 10;

          add_newline = false;

          cmd_duration = {
            min_time = 500;
            format = "underwent [$duration](bold yellow)";
          };

          container = {
            format = "[$symbol \[$name\]]($style) ";
          };

          directory = {
            format = "[$path]($style)[$read_only]($read_only_style) ";
            style = "green bold dimmed";
            truncation_length = 1;
            truncation_symbol = "»/";
          };

          docker_context = {
            format = "via [🐋 $context](blue bold)";
          };

          dotnet = {
            symbol = "🥅 ";
            style = "green";
            heuristic = false;
          };

          fill = {
            symbol = "-";
            style = "bold green";
          };

          fossil_branch = {
            symbol = "🦎 ";
            truncation_length = 4;
            truncation_symbol = "";
          };

          git_branch = {
            symbol = "🌱 ";
            truncation_length = 4;
            truncation_symbol = "";
            ignore_branches = ["master" "main"];
          };

          git_commit = {
            commit_hash_length = 4;
            tag_symbol = "🔖 ";
          };

          git_state = {
            format = "[\($state( $progress_current of $progress_total)\)]($style) ";
            cherry_pick = "[🍒 PICKING](bold red)";
          };

          git_metrics = {
            added_style = "bold blue";
            format = "[+$added]($added_style)/[-$deleted]($deleted_style) ";
          };

          git_status = {
            conflicted = "C";
            ahead = "↑";
            behind = "↓";
            diverged = "↕";
            up_to_date = "✔";
            untracked = "??";
            stashed = "S";
            modified = "M";
            staged = "[++\($count\)](green)";
            renamed = "R";
            deleted = "D";
          };

          golang = {
            format = "[Go:$version](bold cyan) ";
          };

          hostname = {
            ssh_only = true;
            format = "[$ssh_symbol](bold blue) on [$hostname](bold red) ";
            trim_at = ".companyname.com";
            disabled = false;
          };

          line_break = {
            disabled = true;
          };

          localip = {
            ssh_only = true;
            format = "@[$localipv4](bold red) ";
            disabled = false;
          };

          lua = {
            format = "via [🌕 $version](bold blue) ";
          };

          memory_usage = {
            disabled = true;
            threshold = -1;
            symbol = " ";
            style = "bold dimmed green";
          };

          nodejs = {
            format = "via [🤖 $version](bold green) ";
          };

          os = {
            format = "on [($name )]($style)";
            style = "bold blue";
            disabled = true;
          };

          package = {
            format = "via [🎁 $version](208 bold) ";
          };

          python = {
            python_binary = "python3";
          };

          shell = {
            disabled = true; };

          sudo = {
            style = "bold green";
            symbol = "sudo ";
            disabled = false;
          };

          time = {
            disabled = true;
            format = "🕙[\[ $time \]]($style) ";
            time_format = "%T";
            utc_time_offset = "-5";
            time_range = "10:00:00-14:00:00";
          };

          username = {
            disabled = true;
            style_user = "white bold";
            style_root = "black bold";
            format = "[$user]($style) ";
            show_always = true;
          };
        };
      };

      programs.eza = {
        enable = true;
        enableAliases = true;
        icons = true;
      };

      programs.fzf = {
        enable = true;
        enableZshIntegration = true;
      };

      programs.zoxide = {
        enable = true;
        enableZshIntegration = true;
      };

      programs.alacritty = {
        enable = true; 
        settings = {
          window = {
            opacity = 0.8;
          };
          shell = "zsh";
          font = {
            normal = {
              family = "MonaspiceNe NF";
              style = "Regular";
            };
            italic = {
              family = "MonaspiceRn NF";
              style = "Regular";
            };
          };
        };
      };

     # programs.eww = {
     # };

      programs.tealdeer = {
        enable = true;
#        settings = {
#          display = {
#            use_pager = false;
#            compact = false;
#          };
#
#          style = {
#            description = {
#              foreground = "white";
#            };
#            command_name = {
#              foreground = { rgb = "{ r = 255, g = 190, b = 255 }"; }; # b784b7
#            };
#            example_text = {
#              foreground = { rgb = "{ r = 220, g = 180, b = 220 }"; }; # e493b3
#            };
#            example_code = {
#              foreground = { rgb = "{ r = 255, g = 205, b = 206 }"; }; # eea5a6
#            };
#            example_variable = {
#              foreground = { rgb = "{ r = 180, g = 160, b = 220 }"; }; # 8e7ab5
#            };
#          };
#
#          updates = {
#            auto_update = true;
#            auto_update_interval_hours = 24;
#          };
#        };
      };

      programs.fuzzel = {
        enable = true;
        # settings = {
        #   icon-theme = "Papirus-Dark";
        #   width = 25;
        #   font = "Hack:weight=medium:size=12";
        #   line-height = 14;
        #   fields = "name,generic,comment,categories,filename,keywords";
        #   terminal = "foot -e";
        #   prompt = ">   ";
        #   main = {
        #     layer = "overlay";
        #   };
        #   
        #   colors = {
        #     background = "000000aa";
        #     selection = "C188DAaa";
        #     border = "ffffff20";
        #     text = "ffffffff";
        #     selection-text = "000000ff";
        #   };

        #   border = {
        #     radius = 4;
        #   };

        #   dmenu = {
        #     exit-immediately-if-empty = true;
        #   };
        # };
      };

      programs.btop = {
        enable = true; 
        settings = {
          theme_background = false;
          truecolor = true;
          force_tty = false;
          presets = "cpu:1:default,proc:0:default cpu:0:default,mem:0:default,net:0:default cpu:0:block,net:0:tty";
          vim_keys = true;
          rounded_corners = true;
          graph_symbol = "braille";
          graph_symbol_cpu = "default";
          graph_symbol_gpu = "default";
          graph_symbol_mem = "default";
          graph_symbol_net = "default";
          graph_symbol_proc = "default";
          shown_boxes = "cpu mem net proc";
          update_ms = 1000;
          proc_sorting = "pid";
          proc_reversed = false;
          proc_tree = true;
          proc_colors = true;
          proc_gradient = true;
          proc_per_core = true;
          proc_mem_bytes = true;
          proc_cpu_graphs = true;
          proc_info_smaps = false;
          proc_left = false;
          proc_filter_kernel = true;
          proc_aggregate = false;
          cpu_graph_upper = "total";
          cpu_graph_lower = "total";
          show_gpu_info = "Auto";
          cpu_invert_lower = true;
          cpu_single_graph = false;
          cpu_bottom = false;
          show_uptime = true;
          check_temp = true;
          cpu_sensor = "Auto";
          show_coretemp = true;
          cpu_core_map = "";
          temp_scale = "celsius";
          base_10_sizes = false;
          show_cpu_freq = true;
          clock_format = "%X";
          background_update = true;
          custom_cpu_name = "";
          disks_filter = "";
          mem_graphs = true;
          mem_below_net = false;
          zfs_arc_cached = true;
          show_swap = true;
          swap_disk = true;
          show_disks = true;
          only_physical = true;
          use_fstab = true;
          zfs_hide_datasets = false;
          disk_free_priv = false;
          show_io_stat = true;
          io_mode = false;
          io_graph_combined = false;
          io_graph_speeds = "";
          net_download = 100;
          net_upload = 100;
          net_auto = false;
          net_sync = true;
          net_iface = "";
          show_battery = true;
          selected_battery = "Auto";
          show_battery_watts = true;
          log_level = "WARNING";
          nvml_measure_pcie_speeds = true;
          gpu_mirror_graph = true;
        };
      };

      programs.bat = {
        enable = true; 
        config = {
          paging = "always";
          pager = "less -RF";
        };
      };

      programs.chromium = {
        enable = true;
        package = pkgs.brave;
        commandLineArgs = [
          "--ozone-platform-hint=wayland"
        ];
        extensions = [
          "cjpalhdlnbpafiamejdnhcphjbkeiagm" # UBlock Origin
          "mnjggcdmjocbbbhaepdhchncahnbgone" # SponsorBlock
          "naepdomgkenhinolocfifgehidddafch" # Browserpass
        ];
      };

      programs.browserpass = {
        enable = true;
        browsers = [ "brave" ];
      };

      programs.gh = {
        enable = true;
        settings = {
          version = "1";
          git_protocol = "ssh";
        };
      };

      programs.git = {
        enable = true;
        userName = "Kaniel Kirby";
        userEmail = "piratey7007@runbox.com";
      };

      programs.password-store = {
        enable = true;
        package = pkgs.gopass;
        settings = {
          PASSWORD_STORE_DIR = "/home/mx/.config/password-store";
        };
      };

      services.mako = {
        enable = true;
        sort = "-time";
        layer = "overlay";
        backgroundColor = "#00000060";
        width = 300;
        height = 110;
        borderSize = 1;
        borderColor = "#FFFFFF80";
        padding = "10";
        borderRadius = 2;
        icons = true;
        maxIconSize = 64;
        defaultTimeout = 5000;
        ignoreTimeout = true;
        font = "Noto Sans";
#        extraConfig = ''
#          [urgency=low];
#          border-color=#FFFFFF80;
#          [urgency=normal];
#          border-color=#FFFFFF80;
#          [urgency=high];
#          border-color=#FF0000FF;
#          default-timeout=0;
#          [category=mpd];
#          default-timeout=2000;
#          group-by=category;
#        '';
      };

      programs.vscode = {
        enable = true;
        extensions = with pkgs.vscode-extensions; [
          vscodevim.vim
        ];
      };

#      # programs.thunderbird = {
#      #   enable = true;
#      #   profiles = [];
#      # };
#
    };
  };
}
