{ config, pkgs, environment, ... }:

{
    environment.systemPackages = with pkgs; [
    ];

    programs.mtr.enable = true;
    programs.gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
    };
}
