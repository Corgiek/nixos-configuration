{ inputs
, pkgs
, ...
}: 

{
  environment.systemPackages = with pkgs; [ 
    vim
    neovim
    home-manager
    nerdfonts
    alacritty
  ];

  services.nix-daemon.enable = true;

  programs.zsh.enable = true;

  system.configurationRevision = inputs.rev or inputs.dirtyRev or null;
}

