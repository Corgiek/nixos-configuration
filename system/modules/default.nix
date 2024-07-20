{ inputs
, ...
}:

{
  imports = [
    inputs.stylix.nixosModules.stylix
    ../../modules/stylix

    ./locales
    ./network
    ./programs
    ./security
    ./services
    ./timedate
    ./gaming
    ./users
    ./variables
    ./virtualization
    ./pihole
  ];
}
