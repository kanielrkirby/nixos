{ self, inputs, pkgs, ... }:

{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  users = {
    defaultUserShell = pkgs.zsh;
    users.mx = {
      isNormalUser = true;
      extraGroups = [ "wheel" "libvirtd" "networkmanager" ];
      initialPassword = "asdf";
    };
    mutableUsers = false;
  };

  qt = {
    enable = true;
    platformTheme = "gtk2";
    style = "gtk2";
  };

  home-manager = {
    useGlobalPkgs = true;

    users.mx = { pkgs, config, ... }: {
      home.stateVersion = "23.11";

      services.easyeffects = {
        enable = true;
        preset = "lappy_mctopface";
      };

      xdg.configFile."easyeffects/output".source = builtins.fetchGit {
        url = "https://github.com/ceiphr/ee-framework-presets";
        rev = "27885fe00c97da7c441358c7ece7846722fd12fa";
      };

      gtk = {
        enable = true;
        theme = {
          name = "Catppuccin-Mocha-Standard-Blue-Dark";
          package = pkgs.catppuccin-gtk.override {
            # accents = [ "pink" ];
            # size = "compact";
            # tweaks = [ "rimless" "black" ];
            variant = "mocha";
          };
        };

        iconTheme = {
          package = pkgs.fluent-icon-theme;
          name = "Fluent-dark";
        };

        font = {
          name = "Noto Sans";
          size = 14;
        };
      };

      xdg.configFile = {
        "gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
        "gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
        "gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
      };

      dconf.settings = {
        "org/virt-manager/virt-manager/connections" = {
          autoconnect = [ "qemu:///system" ];
          uris = [ "qemu:///system" ];
        };
        "org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark";
        };
      };

      home.packages = with pkgs; [
        git
        httpie
        nodejs_21
        wl-clipboard
        fw-ectool
        grim
        slurp
        ripgrep
        hyprshade
        signal-desktop
        brightnessctl
        playerctl
        libnotify
        hyprpaper
        codeium
        pinentry
        powertop
        localsend
        vagrant
        catppuccin-papirus-folders
        pkgs.libsForQt5.qtgraphicaleffects
        pkgs.libsForQt5.qtsvg
        pkgs.libsForQt5.qtquickcontrols
      ];

      programs.less.enable = true;

      xdg.configFile."zsh/catppuccin_mocha.zsh".source =
        "${pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "zsh-syntax-highlighting";
          rev = "master";
          sha256 = "sha256-Q7KmwUd9fblprL55W0Sf4g7lRcemnhjh4/v+TacJSfo=";
        }}/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh";

      programs.zsh = {
        enable = true;
        enableAutosuggestions = true;
        syntaxHighlighting.enable = true;
        enableCompletion = true;
        initExtra = ''
          source ${config.xdg.configHome}/zsh/catppuccin_mocha.zsh
          export LANG="en_US.UTF-8"
          export LC_ALL="$LANG"
          export ANKI_WAYLAND="1"
          alias svim="sudo -E -s nvim"
          up() {
              local name=""
              local type="test"  # Default type

              for arg in "$@"; do
                  case $arg in
                      --boot)
                          type="boot"
                          shift
                          ;;
                      --switch)
                          type="switch"
                          shift
                          ;;
                      --test)
                          type="test"
                          shift
                          ;;
                      *)
                          # Assuming the first non-option argument is the name
                          if [[ -z "$name" ]]; then
                              name="$arg"
                          else
                              echo "Error: Unexpected argument: $arg"
                              return 1
                          fi
                          ;;
                  esac
              done

              if [[ -z "$name" ]]; then
                  echo "Error: Name is required."
                  return 1
              fi

              name="$(echo $name | sed "s/ /_/g")"

              sudo NIXOS_LABEL="$name" nixos-rebuild "$type" --flake /etc/nixos#nixos

              wd=$(pwd)
              if [[ "$type" == "boot" || "$type" == "switch" ]]; then
                cd /etc/nixos
                sudo -E git add .
                sudo -E git commit -m "$name"
                cd "$wd"
              fi
          }

          n() {
            args="$@"
            cmd="''${args%% *}"
            args="''${args#* }"
            nix shell "nixpkgs#$cmd" --command $cmd $args
          }
        '';
      };

      programs.atuin = {
        enable = true;
        enableZshIntegration = true;
      };

      programs.starship = 
      let
        flavour = "mocha";
      in
      {
        enable = true;
        enableZshIntegration = true;
        settings = builtins.fromTOML (builtins.readFile (pkgs.fetchFromGitHub
        {
            owner = "catppuccin";
            repo = "starship";
            rev = "master";
            sha256 = "sha256-nsRuxQFKbQkyEI4TXgvAjcroVdG+heKX5Pauq/4Ota0=";
          } + /palettes/${flavour}.toml))
           // {
          palette = "catppuccin_${flavour}";
          format =
            "$username$hostname$localip$shlvl$singularity$kubernetes$directory$vcsh$fossil_branch$git_branch$git_commit$git_state$git_metrics$git_status$hg_branch$pijul_channel$docker_context$package$c$cmake$cobol$daml$dart$deno$dotnet$elixir$elm$erlang$fennel$golang$guix_shell$haskell$haxe$helm$java$julia$kotlin$gradle$lua$nim$nodejs$ocaml$opa$perl$php$pulumi$purescript$python$raku$rlang$red$ruby$rust$scala$solidity$swift$terraform$vlang$vagrant$zig$buf$nix_shell$conda$meson$spack$memory_usage$aws$gcloud$openstack$azure$env_var$crystal$custom$sudo$cmd_duration$line_break$jobs$battery$time$status$os$container$shell$character";
          scan_timeout = 10;

          add_newline = false;

          cmd_duration = {
            min_time = 500;
            format = "underwent [$duration](bold yellow)";
          };

          container = { format = "[$symbol [$name]]($style) "; };

          directory = {
            format = "[$path]($style)[$read_only]($read_only_style) ";
            style = "green bold dimmed";
            truncation_length = 1;
            truncation_symbol = "»/";
          };

          docker_context = { format = "via [🐋 $context](blue bold)"; };

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
            ignore_branches = [ "master" "main" ];
          };

          git_commit = {
            commit_hash_length = 4;
            tag_symbol = "🔖 ";
          };

          git_state = {
            format =
              "[($state( $progress_current of $progress_total))]($style) ";
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
            staged = "[++($count)](green)";
            renamed = "R";
            deleted = "D";
          };

          golang = { format = "[Go:$version](bold cyan) "; };

          hostname = {
            ssh_only = true;
            format = "[$ssh_symbol](bold blue) on [$hostname](bold red) ";
            trim_at = ".companyname.com";
            disabled = false;
          };

          line_break = { disabled = true; };

          localip = {
            ssh_only = true;
            format = "@[$localipv4](bold red) ";
            disabled = false;
          };

          lua = { format = "via [🌕 $version](bold blue) "; };

          memory_usage = {
            disabled = true;
            threshold = -1;
            symbol = " ";
            style = "bold dimmed green";
          };

          nodejs = { format = "via [🤖 $version](bold green) "; };

          os = {
            format = "on [($name )]($style)";
            style = "bold blue";
            disabled = true;
          };

          package = { format = "via [🎁 $version](208 bold) "; };

          python = { python_binary = "python3"; };

          shell = { disabled = true; };

          sudo = {
            style = "bold green";
            symbol = "sudo ";
            disabled = false;
          };

          time = {
            disabled = true;
            format = "🕙[[ $time ]]($style) ";
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
        colors = {
          "bg+" = "#313244";
          bg = "#1e1e2e";
          spinner = "#f5e0dc";
          hl = "#f38ba8";
          fg = "#cdd6f4";
          header = "#f38ba8";
          info = "#cba6f7";
          pointer = "#f5e0dc";
          marker = "#f5e0dc";
          "fg+" = "#cdd6f4";
          prompt = "#cba6f7";
          "hl+" = "#f38ba8";
        };
      };

      programs.zoxide = {
        enable = true;
        enableZshIntegration = true;
      };

      programs.alacritty = {
        enable = true;
        settings = {
          imports = [
            "${pkgs.fetchFromGitHub {
              owner = "alacritty";
              repo = "alacritty-theme";
              rev = "master";
              sha256 = "sha256-+35S6eQkxLBuS/fDKD5bglQDIuz2xeEc5KSaK6k7IjI=";
            }}/themes/catppuccin_mocha.toml"
          ];
          window = { opacity = 0.9; };
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

      programs.tealdeer.enable = true;
      xdg.configFile."tealdeer/config.toml".text = ''
        [display]
        compact = false
        use_pager = false
        
        [style.description]
        foreground = { rgb = { r = 205, g = 214, b = 244 } }
        
        [style.command_name]
        foreground = { rgb = { r = 180, g = 160, b = 220 } }
        
        [style.example_code]
        foreground = { rgb = { r = 205, g = 214, b = 244 } }
        
        [style.example_text]
        foreground = { rgb = { r = 205, g = 214, b = 244 } }
        
        [style.example_variable]
        foreground = { rgb = { r = 205, g = 214, b = 244 } }
        
        [updates]
        auto_update = true
        auto_update_interval_hours = 24
      '';

      programs.waybar = {
        enable = true;
        settings = {
          mainBar = {
            layer = "top";
            position = "left";
            modules-left = [ "hyprland/workspaces" ];
            modules-center = [ ];
            modules-right = [
              "pulseaudio"
              "network"
              "backlight"
              "battery"
              "clock"
              "tray"
              "custom/power"
            ];

            "hyprland/workspaces" = {
              disable-scroll = true;
              sort-by-name = false;
              active-only = false;
              all-outputs = true;
              format = "{icon}";
              format-icons = { default = ""; };
            };

            pulseaudio = {
              format = " {icon} ";
              format-muted = "󰖁";
              format-icons = [ "" "" "" ];
              tooltip = true;
              tooltip-format = "{volume}%";
            };

            network = {
              format-wifi = "󰤨 ";
              format-disconnected = "󰤭 ";
              format-ethernet = "󰈀 ";
              tooltip = true;
              tooltip-format = "{signalStrength}%";
            };

            backlight = {
              device = "intel_backlight";
              format = "{icon}";
              format-icons = [ "" "" "" "" "" "" "" "" "" ];
              tooltip = true;
              tooltip-format = "{percent}%";
            };

            battery = {
              states = {
                warning = 30;
                critical = 15;
              };
              format = "{icon}";
              format-charging = "󰂄";
              format-plugged = "󰂄";
              format-icons =
                [ "󰂃" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
              tooltip = true;
              tooltip-format = "{capacity}%";
            };

            clock = {
              tooltip-format = ''
                <big>{:%Y %B}</big>
                <tt><small>{calendar}</small></tt>'';
              format-alt = ''
                 {:%d
                 %m
                %Y}'';
              format = ''
                {:%H
                %M}'';
            };

            tray = {
              icon-size = 18;
              spacing = 20;
            };
          };
        };
        style = ''
          /*
          *
          * Catppuccin Mocha palette
          * Maintainer: rubyowo
          *
          */

          @define-color base   #1e1e2e;
          @define-color mantle #181825;
          @define-color crust  #11111b;

          @define-color text     #cdd6f4;
          @define-color subtext0 #a6adc8;
          @define-color subtext1 #bac2de;

          @define-color surface0 #313244;
          @define-color surface1 #45475a;
          @define-color surface2 #585b70;

          @define-color overlay0 #6c7086;
          @define-color overlay1 #7f849c;
          @define-color overlay2 #9399b2;

          @define-color blue      #89b4fa;
          @define-color lavender  #b4befe;
          @define-color sapphire  #74c7ec;
          @define-color sky       #89dceb;
          @define-color teal      #94e2d5;
          @define-color green     #a6e3a1;
          @define-color yellow    #f9e2af;
          @define-color peach     #fab387;
          @define-color maroon    #eba0ac;
          @define-color red       #f38ba8;
          @define-color mauve     #cba6f7;
          @define-color pink      #f5c2e7;
          @define-color flamingo  #f2cdcd;
          @define-color rosewater #f5e0dc;

          * {
            font-family: MonaspiceXe Nerd Font Regular;
            font-size: 16px;
            min-height: 0;
          }

          window#waybar {
            background: transparent;
          }

          #workspaces {
            border-radius: 1rem;
            background-color: @surface0;
            margin-top: 1rem;
            margin: 7px 3px 0px 7px;
          }

          #workspaces button {
            color: @pink;
            border-radius: 1rem;
            padding-left: 6px;
            margin: 5px 0;
            box-shadow: inset 0 -3px transparent;
            transition: all 0.5s cubic-bezier(.55,-0.68,.48,1.68);
            background-color: transparent;
          }

          #workspaces button.active {
            color: @flamingo;
            border-radius: 1rem;
          }

          #workspaces button:hover {
            color: @rosewater;
            border-radius: 1rem;
          }

          #tray,
          #network,
          #backlight,
          #clock,
          #battery,
          #pulseaudio,
          #custom-lock,
          #custom-power {
            background-color: @surface0;
            margin: 7px 3px 0px 7px;
            padding: 10px 5px 10px 5px;
            border-radius: 1rem;
          }

          #clock {
            color: @lavender;
          }

          #battery {
            color: @green;
          }

          #battery.charging {
            color: @green;
          }

          #battery.warning:not(.charging) {
            color: @red;
          }

          #network {
              color: @flamingo;
          }

          #backlight {
            color: @yellow;
          }

          #pulseaudio {
            color: @pink;
          }

          #pulseaudio.muted {
              color: @red;
          }

          #custom-power {
              border-radius: 1rem;
              color: @red;
              margin-bottom: 1rem;
          }

          #tray {
            border-radius: 1rem;
          }

          tooltip {
              background: @base;
              border: 1px solid @pink;
          }

          tooltip label {
              color: @text;
          }
        '';

      };

      programs.fuzzel = {
        enable = true;
         settings = {
           main = {
             icon-theme = "Fluent-dark";
             width = 25;
             font = "Noto Sans:weight=medium:size=16";
             line-height = 16;
             fields = "name,generic,comment,categories,filename,keywords";
             terminal = "alacritty -e";
             prompt = "> ";
             layer = "overlay";
           };
           colors = {
             background = "1e1e2edd";
             text = "cdd6f4ff";
             match = "f38ba8ff";
             selection = "585b70ff";
             selection-match = "f38ba8ff";
             selection-text = "cdd6f4ff";
             border = "b4befeff";
           };

           border = {
             radius = 6;
           };

           dmenu = {
             exit-immediately-if-empty = true;
           };
         };
      };

      xdg.configFile."btop/themes/catppuccin_mocha.theme".source = "${pkgs.fetchFromGitHub {
        owner = "catppuccin";
        repo = "btop";
        rev = "master";
        sha256 = "sha256-jodJl4f2T9ViNqsY9fk8IV62CrpC5hy7WK3aRpu70Cs=";
      }}/themes/catppuccin_mocha.theme";

      programs.btop = {
        enable = true;
        settings = {
          color_theme = "catppuccin_mocha";
          theme_background = true;
          truecolor = true;
          force_tty = false;
          presets =
            "cpu:1:default,proc:0:default cpu:0:default,mem:0:default,net:0:default cpu:0:block,net:0:tty";
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
          theme = "catppuccin";
        };
        themes = {
          catppuccin = {
           src = "${pkgs.fetchFromGitHub {
             owner = "catppuccin";
             repo = "bat";
             rev = "master";
             sha256 = "sha256-PLbTLj0qhsDj+xm+OML/AQsfRQVPXLYQNEPllgKcEx4=";
           }}/themes/Catppuccin Mocha.tmTheme";
         };
        };
      };

      programs.chromium = {
        enable = true;
        package = pkgs.brave;
        commandLineArgs = [ "--ozone-platform-hint=wayland" ];
        extensions = [
          "cjpalhdlnbpafiamejdnhcphjbkeiagm" # UBlock Origin
          "mnjggcdmjocbbbhaepdhchncahnbgone" # SponsorBlock
          "naepdomgkenhinolocfifgehidddafch" # Browserpass
          "hipekcciheckooncpjeljhnekcoolahp" # Tabliss
        ];
      };

#      home.file.".config/BraveSoftware/Brave-Browser/Default/Preferences".source = "${self}/../extra/brave-preferences.json";

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
        settings = { PASSWORD_STORE_DIR = "/home/mx/.config/password-store"; };
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
        extensions = with pkgs.vscode-extensions; [ vscodevim.vim ];
      };

      programs.swaylock = {
        enable = true;
        settings = {
          color="1e1e2e";
          bs-hl-color = "f5e0dc";
          caps-lock-bs-hl-color = "f5e0dc";
          caps-lock-key-hl-color = "a6e3a1";
          inside-color = "00000000";
          inside-clear-color = "00000000";
          inside-caps-lock-color = "00000000";
          inside-ver-color = "00000000";
          inside-wrong-color = "00000000";
          key-hl-color = "a6e3a1";
          layout-bg-color = "00000000";
          layout-border-color = "00000000";
          layout-text-color = "cdd6f4";
          line-color = "00000000";
          line-clear-color = "00000000";
          line-caps-lock-color = "00000000";
          line-ver-color = "00000000";
          line-wrong-color = "00000000";
          ring-color = "b4befe";
          ring-clear-color = "f5e0dc";
          ring-caps-lock-color = "fab387";
          ring-ver-color = "89b4fa";
          ring-wrong-color = "eba0ac";
          separator-color = "00000000";
          text-color = "cdd6f4";
          text-clear-color = "f5e0dc";
          text-caps-lock-color = "fab387";
          text-ver-color = "89b4fa";
          text-wrong-color = "eba0ac";
        };
      };

      #       programs.thunderbird = {
      #         enable = true;
      #         profiles = [];
      #       };
      #
    };
  };
  security.pam.services.swaylock = { };
}

