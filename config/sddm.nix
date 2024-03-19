{
  services.xserver.displayManager = {
    sddm = {
      enable = true;
      wayland.enable = true;
      #   autoLogin = {
      #     relogin = true;
      #   };
    };
    # autoLogin = {
    #   enable = true;
    #   user = "mx";
    # };
  };
}
