{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.services.mullvad-vpn;
in {
  options.${namespace}.services.mullvad-vpn = {
    enable = mkBoolOpt false "Whether or not to enable mullvad-vpn.";
  };

  config = mkIf cfg.enable {
    services.mullvad-vpn = {
      enable = true;
    };
    sops.templates = {
      "mullvad-vpn/device.json".content = ''
        {
          "logged_in": {
            "account_token": "${config.sops.placeholder."mullvad.net/username"}",
            "device": {
              "id": "52116461-1264-4666-a60e-f7c08a246b52",
              "name": "proper cobra",
              "wg_data": {
                "private_key": "OM1DpL5eKViuCXmyU+83/hxbBlpUidM13/rabpVgJOk=",
                "addresses": {
                  "ipv4_address": "10.139.184.54/32",
                  "ipv6_address": "fc00:bbbb:bbbb:bb01:d:0:b:b836/128"
                },
                "created": "2024-06-14T09:31:18.892979352Z"
              },
              "hijack_dns": false,
              "created": "2024-04-04T21:50:46Z"
            }
          }
        }
      '';
    };

    etc = {
      "mullvad-vpn/device.json".source = config.sops.templates."mullvad-vpn/device.json".path;
      "mullvad-vpn/settings.json".source = ''
        {
          "allow_lan": false,
          "api_access_methods": {
            "custom": [],
            "direct": {
              "access_method": {
                "built_in": "direct"
              },
              "enabled": true,
              "id": "9bab5183-5734-48c3-8b6f-b10e28cbf570",
              "name": "Direct"
            },
            "mullvad_bridges": {
              "access_method": {
                "built_in": "bridge"
              },
              "enabled": true,
              "id": "8692c32f-3d54-4728-b7f2-e0e4a5d1f604",
              "name": "Mullvad Bridges"
            }
          },
          "auto_connect": false,
          "block_when_disconnected": false,
          "bridge_settings": {
            "bridge_type": "normal",
            "custom": null,
            "normal": {
              "location": "any",
              "ownership": "any",
              "providers": "any"
            }
          },
          "bridge_state": "auto",
          "custom_lists": {
            "custom_lists": []
          },
          "obfuscation_settings": {
            "selected_obfuscation": "off",
            "udp2tcp": {
              "port": "any"
            }
          },
          "relay_overrides": [],
          "relay_settings": {
            "normal": {
              "location": {
                "only": {
                  "location": {
                    "country": "us"
                  }
                }
              },
              "openvpn_constraints": {
                "port": "any"
              },
              "ownership": "any",
              "providers": "any",
              "tunnel_protocol": "any",
              "wireguard_constraints": {
                "entry_location": {
                  "only": {
                    "location": {
                      "country": "se"
                    }
                  }
                },
                "ip_version": "any",
                "port": "any",
                "use_multihop": false
              }
            }
          },
          "settings_version": 8,
          "show_beta_releases": false,
          "tunnel_options": {
            "dns_options": {
              "custom_options": {
                "addresses": []
              },
              "default_options": {
                "block_ads": false,
                "block_adult_content": false,
                "block_gambling": false,
                "block_malware": false,
                "block_social_media": false,
                "block_trackers": false
              },
              "state": "default"
            },
            "generic": {
              "enable_ipv6": false
            },
            "openvpn": {
              "mssfix": null
            },
            "wireguard": {
              "mtu": null,
              "quantum_resistant": "auto",
              "rotation_interval": null
            }
          }
        }
      '';
    };
  };
}
