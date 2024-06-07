{ lib
, rustPlatform
, fetchFromGitHub
}:

rustPlatform.buildRustPackage rec {
  pname = "uutils-util-linux";
  version = "0.0.1";

  src = fetchFromGitHub {
    owner = "uutils";
    repo = "util-linux";
    rev = version;
    hash = "sha256-FZ6JgRPkDr7gyDhpVo8xE1QZZoI1iH0/2D4Tgr7XyA8=";
  };

  doCheck = false;

  cargoSha256 = "sha256-5b4aeFS95xsYUDAxj7gzCqdFxUYMOc1zFN/EEBWXlrE=";

  meta = with lib; {
    description = "Cross-platform Rust rewrite of the GNU util-linux";
    longDescription = ''
      uutils is an attempt at writing universal (as in cross-platform)
      CLI utils in Rust. This repo is to aggregate the GNU util-linux rewrites.
    '';
    homepage = "https://github.com/uutils/util-linux";
    maintainers = with maintainers; [ kanielrkirby ];
    license = licenses.mit;
    platforms = platforms.unix;
  };
}
