{ lib
, stdenv
, fetchFromGitHub
, rustPlatform
, cargo
, sphinx
, Security
, libiconv
, prefix ? "uutils-"
, buildMulticallBinary ? true
}:

stdenv.mkDerivation rec {
  pname = "uutils-util-linux";
  version = "0.0.1";

  src = fetchFromGitHub {
    owner = "uutils";
    repo = "util-linux";
    rev = version;
    hash = "sha256-25jmlG3MWzAaJEmMHruA6H+nqx2QHnYX9c9SKqrQRE4=";
  };

  cargoDeps = rustPlatform.fetchCargoTarball {
    inherit src;
    name = "${pname}-${version}";
    hash = "sha256-lQoOkiRga2aS8GNgLcHdid1/1u3johYEcGi9oOVsdJs=";
  };

  nativeBuildInputs = [ rustPlatform.cargoSetupHook sphinx ];

  buildInputs = lib.optionals stdenv.isDarwin [ Security libiconv ];

  makeFlags = [
    "CARGO=${cargo}/bin/cargo"
    "PREFIX=${placeholder "out"}"
    "PROFILE=release"
    "INSTALLDIR_MAN=${placeholder "out"}/share/man/man1"
  ] ++ lib.optionals (prefix != null) [ "PROG_PREFIX=${prefix}" ]
  ++ lib.optionals buildMulticallBinary [ "MULTICALL=y" ];

  # too many impure/platform-dependent tests
  doCheck = false;

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
