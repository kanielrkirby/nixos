inputs: path:

let
  lib = inputs.nixpkgs.lib;

  getArchAndOS = name: let
    parts = lib.splitString "-" name;
  in {
    arch = builtins.elemAt parts 0;
    os = builtins.elemAt parts 1;
  };

  importHosts = rootPath: let
    entries = builtins.readDir rootPath;
  in lib.foldl' (acc: sys: let
    system = getArchAndOS sys;
    archPath = "${rootPath}/${sys}";
    pkgs = import inputs.nixpkgs {
      system = sys;
      config = { allowUnfree = true; };
    };
    systemFunction = if system.os == "darwin" then
      inputs.darwin.lib.darwinSystem
    else
      inputs.nixpkgs.lib.nixosSystem;

    hostConfigs = builtins.readDir archPath;
    accumulateHosts = lib.foldl' (hostAcc: hostName: let
      configPath = "${archPath}/${hostName}/default.nix";
      configuration = systemFunction {
        inherit pkgs lib;
        system = sys;
        specialArgs = { inherit inputs; };
        modules = [
          ../hardware-configuration.nix
          { 
            imports = [inputs.home-manager.nixosModules.home-manager];
            config.gearshift.hostName = hostName;
          }
          ./module-import.nix
          (import configPath)
        ];
      };
    in hostAcc // { ${hostName} = configuration; }) {} (builtins.attrNames hostConfigs);

  in if system.os == "darwin" then
    acc // { darwinConfigurations = (acc.darwinConfigurations or {}) // accumulateHosts; }
  else
    acc // { nixosConfigurations = (acc.nixosConfigurations or {}) // accumulateHosts; }
  ) {} (builtins.attrNames entries);

in importHosts path

