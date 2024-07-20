_:

{
  networking = {
    nameservers = [
      "192.168.1.8"
      "8.8.8.8"
      "8.8.4.4"
    ];

    firewall = {
      enable = true;

      allowedTCPPorts = [
        8384
        22000
        8554
        8889
        3000
        16262
      ];

      allowedUDPPorts = [
        22000
        21027
        8000
        8001
        8889
        16262
      ];

      allowedTCPPortRanges = [
        { from = 1714; to = 1764; } # KDE Connect
      ];

      allowedUDPPortRanges = [
        { from = 1714; to = 1764; } # KDE Connect
      ];
    };
  };
}
