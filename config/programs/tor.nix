{
  services.tor = {
    openFirewall = true;

    relay = {
      enable = true;
      role = "relay";
    };

    settings = {
      ContactInfo = "mistor0194@runbox.com";
      Nickname = "mistor";
      ORPort = 9001;
      # Slow
      ControlPort = 9051;
      BandWidthRate = "1 MBytes";
    };

    # Fast
    client.enable = true;
  };
}
