_:

{
  networking = {
    hostId = "3988cd3f";

    nameservers = [
      "8.8.8.8"
      "8.8.4.4"
    ];

    firewall = {
      enable = true;

      allowedTCPPorts = [
        8384
        22000
        2257
        6371
        4485
        8896
        25565
      ];

      allowedUDPPorts = [
        22000
        21027
        4485
        8896
        25565
      ];
    };
  };
}

