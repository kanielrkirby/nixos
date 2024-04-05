{ pkgs, inputs, config, username, ... }:

{
  imports = [ inputs.sops-nix.nixosModules.sops ];

#  sops.secrets."login/nixos/password".neededForUsers = true;
  sops.secrets."gpg/primary/key" = { };
  sops.secrets."gpg/primary/content" = { };

#  users.users."${username}" = {
#    hashedPasswordFile = config.sops.secrets."login/nixos/password".path;
#  };

  sops.age.keyFile = "/home/${username}/.config/sops/age/keys.txt";
  sops.defaultSopsFile = ../secrets/secrets/primary.yaml;
  sops.defaultSopsFormat = "yaml";

  environment.systemPackages = with pkgs; [
    jq
    yq
    sops
    age
    (pkgs.writeShellScriptBin "sops-to-pass" ''
      force=""
      args=("$@")
      _args=("''${args[@]}")
      args=()
      for arg in "''${_args[@]}"; do
          if [ "$arg" = "-f" ]; then
              force="true"
          else
              args+=("$arg")
          fi
      done
      global_path="/home/mx/.config/password-store"
      g_yaml="$(sops -d "/etc/nixos/config/secrets/secrets/primary.yaml")"

      # Process each scalar value
      function process() {
          local json="$1"
          local path="$2"

          for key in $(jq -r 'to_entries | .[] | .key' <<< "$json"); do
              inner_key="$(echo "$json" | yq -r ".\"$key\" | keys | .[0]")"
              inner_key_type="$(echo "$json" | yq -r ".\"$key\".\"$inner_key\" | type")"
              if [ "$inner_key_type" = "object" ]; then
                  process "$(echo "$json" | yq -r ".\"$key\"")" "$path.\"$key\""
              else
                  create_file "$path.\"$key\""
              fi
          done
      }

      function create_file() {
          local accessor="$1"
          local path
          path="$global_path/$(echo "$accessor" | sed 's/"."/\//g' | sed 's/^\."//' | sed 's/"$//')"
          local basic_path
          basic_path="''${path//$global_path\//}"
          local content
          content="$(echo "$g_yaml" | yq -ry "$accessor")"
          # Password fix
          content="$( echo "$content" | sed 's/^password: //' )"

          mkdir -p "$(dirname "$path")"
          if [ "$(gopass ls | rg "$basic_path")" != "" ]; then
              echo "File at \"$path.gpg\" already exists"
              if [ "$force" = "true" ]; then
                  echo "Overwriting..."
                  gopass rm -f "$basic_path"
              else
                  echo "Skipping... (delete or move file, or pass -f to overwrite ALL files)"
                  return
              fi
          fi
          echo "$content" | gopass insert -ma "$basic_path"
      }

      if [ "$(gpg --list-secret-keys | rg "$(sudo -E cat "${
        config.sops.secrets."gpg/primary/key".path
      }")")" == "" ]; then
          sudo -E gpg --import "$(cat "${
            config.sops.secrets."gpg/primary/content".path
          }")"
      fi

      process "$(echo "$g_yaml" | yq -rj)"
    '')
  ];
}
