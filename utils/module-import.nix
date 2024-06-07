{ lib, ... }:

let
  # Function to recursively read directories and collect .nix file paths
  readDirectory = path:
    let
      entries = builtins.readDir path;  # Get directory contents
    in
      builtins.concatMap (name:  # Map over each entry in the directory
        let
          newPath = "${path}/${name}";  # Construct the full path of the entry
          entryType = builtins.getAttr name entries;  # Get the type of the entry (directory or regular)
        in
          if entryType == "directory" && name != "derivations" then
            readDirectory newPath  # Recursively call readDirectory if it's a directory
          else if entryType == "regular" && lib.strings.hasSuffix ".nix" name then
            [ newPath ]  # Collect the file path if it's a regular .nix file
          else
            []  # Ignore non-.nix files or other types of entries
      ) (builtins.attrNames entries);  # Get the names of all entries in the directory
in
  { imports = readDirectory ../modules; }  # Collect paths without importing

