{ lib
, buildGoModule
, fetchFromGitHub
, xorg
}:

buildGoModule rec {
  pname = "lazysql";
  version = "0.1.8";

  src = fetchFromGitHub {
    owner = "jorgerojas26";
    repo = "lazysql";
    rev = "v${version}";
    hash = "sha256-yPf9/SM4uET/I8FsDU1le9JgxELu0DR9k7mv8PnBwvQ=";
  };

  vendorHash = "sha256-tgD6qoCVC1ox15VPJWVvhe4yg3R81ktMuW2dsaU69rY=";

  buildInputs = [
    xorg.libX11
  ];

  meta = with lib; {
    description = "A cross-platform TUI database management tool written in Go.";
    homepage = "https://github.com/jorgerojas26/lazysql";
    license = licenses.mit;
    maintainers = with maintainers; [ kanielrkirby ];
    mainProgram = "lazysql";
  };
}
