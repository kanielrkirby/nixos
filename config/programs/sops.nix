{ pkgs, inputs, config, username, ... }:

{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  # Login PW

  sops.secrets.nixos-password.neededForUsers = true;

  users.users."${username}" = {
    hashedPasswordFile = config.sops.secrets.nixos-password.path;
  };

  sops.age.keyFile = "/home/${username}/.config/sops/age/keys.txt";
  sops.defaultSopsFile = ../secrets/.sops.yaml;
  sops.defaultSopsFormat = "yaml";

  environment.systemPackages = with pkgs; [
    sops
    age
    (pkgs.writeShellScriptBin "sops-to-pass" ''

      # CHECKS

      if [ ! -f /home/${username}/.config/sops/age/keys.txt ]; then
        echo "No keys found. Remember to add the key from your Yubikey."
        exit 1
      fi

      if [ ! -d /home/${username}/.config/password-store ]; then
        mkdir -p /home/${username}/.config/password-store
      fi

      if [ ! command -v sops || ! command -v gopass || ! command -v yq || ! command -v age ]; then
        echo "Please install the following:"
        echo "  - sops"
        echo "  - gopass"
        echo "  - yq"
        echo "  - age"
        exit 1
      fi

      # VARS

      txt=$(sops -a /home/${username}/.config/sops/age/keys.txt -d ${
        config.sops.secrets."primary".path
      })

      # FUNC

      function process_yaml() {
        local path=$1
        local indent=$2
        local value=$(yq eval ".[\"$key\"]" - <<< "$input_yaml")

        local keys=$(yq eval 'keys' - <<< "$input_yaml")

        for key in keys; do
            local value=$(yq eval ".[\"$key\"]" - <<< "$input_yaml")

            # Check if the value is an object (associative array)
            if [[ $(yq eval 'type' - <<< "$value") == "map" ]]; then
                # Recursively process the next level
                process_yaml "$path/$key" "$value" $(($indent_level+1))
            else
                if [[ $indent_level -gt 0 ]]; then
                    local filename="$(echo "$path" | sed 's/\//_/g').gpg"
                    echo "Saving $filename"
                    echo "$input_yaml" > "$filename"
                    return
                fi
            fi
        done
      }

      # MAIN

      process_yaml "" "$txt" 0
    '')
  ];
}
