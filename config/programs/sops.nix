{ pkgs, inputs, config, username, ... }:

{
  imports = [ inputs.sops-nix.nixosModules.sops ];

  sops.secrets."login/nixos/password".neededForUsers = true;

  users.users."${username}" = {
    hashedPasswordFile = config.sops.secrets."login/nixos/password".path;
  };

  sops.age.keyFile = "/home/${username}/.config/sops/age/keys.txt";
  sops.defaultSopsFile = ../secrets/secrets/primary.json;
  sops.defaultSopsFormat = "json";

  environment.systemPackages = with pkgs; [
    yq
    sops
    age
    (pkgs.writeShellScriptBin "sops-to-pass" ''
      yaml="$(sops -d "${config.sops.defaultSopsFile}")"
      handle() {
          local yaml_data="$1"
          local prefix="$2"
      
          # Read keys and their types
          readarray -t keys_and_types < <(echo "$yaml_data" | yq '. as $in | paths(scalars) | join(".")')
      
          for kt in "''${keys_and_types[@]}"; do
              local key="''${kt%:*}"
              local type="''${kt##*:}"
              local formatted_key="''${key//\"/}" # Remove quotes from the key
      
              if [ "$type" == "string" ]; then
                  # Extract the string value
                  local value=$(echo "$yaml_data" | yq ".$formatted_key" -r)
      
                  # Replace . with / in key path for the filename
                  local filepath="''${prefix}''${formatted_key//./\/}.temp"
                  mkdir -p "$(dirname "$filepath")"
                  echo "$value" > "$filepath"
              else
                  # If it's not a string, handle recursively
                  local new_prefix="$prefix$formatted_key/"
                  local new_yaml_data=$(echo "$yaml_data" | yq ".$formatted_key")
                  handle "$new_yaml_data" "$new_prefix"
              fi
          done
      }
      
      # Start processing
      handle "$yaml"
    '')
  ];
}
