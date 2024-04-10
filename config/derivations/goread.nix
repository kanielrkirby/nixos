{ pkgs, ... }:

{
  environment.systemPackages = [
    (pkgs.buildGoModule rec {
      pname = "goread";
      version = "1.6.4";
    
      src = pkgs.fetchFromGitHub {
        owner = "TypicalAM";
        repo = "goread";
        rev = "v${version}";
        hash = "sha256-m6reRaJNeFhJBUatfPNm66LwTXPdD/gioT8HTv52QOw=";
      };
    
      vendorHash = "sha256-/kxEnw8l9S7WNMcPh1x7xqiQ3L61DSn6DCIvJlyrip0=";
    
      meta = with pkgs.lib; {
        description = "RSS reader for the terminal in BubbleTea and Golang.";
        homepage = "https://github.com/TypicalAM/goread";
        license = pkgs.lib.licenses.mit;
        maintainers = with pkgs.lib.maintainers; [ ];
      };
    })
  ];
}
