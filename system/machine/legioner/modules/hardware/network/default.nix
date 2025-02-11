_:

{
  networking = {
    nameservers = [
      "8.8.8.8"
      "8.8.4.4"
    ];

    firewall = {
      enable = true;

      allowedTCPPorts = [
        8384
        22000
      ];

      allowedUDPPorts = [
        22000
        21027
      ];
    };
  };
}

