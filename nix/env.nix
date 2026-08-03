{ config, pkgs, lib, ... }:

{

  environment.variables = {
     NIXOS_OZONE_WL = "1";
  };

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
    QT_QPA_PLATFORM = "wayland;xcb";
  };  

  environment.shellAliases = {
     shutdown = "shutdown now";
     v = "nvim";
     sv = "sudo nvim";
     nrs = "sudo nixos-rebuild switch";
     nrs-flake = "sudo nixos-rebuild switch --flake .";
     nfs = "sudo nix flake update";
     nfu = "sudo nix flake update nixpkgs nixpkgs-unstable";
     hms = "home-manager switch";
     svn = "sudo nvim /etc/nixos";
     restart = "systemctl restart display-manager";
   };

  environment.interactiveShellInit = ''
    # Bind Ctrl+Left/Right to word movement
    bindkey '^[[1;5D' backward-word
    bindkey '^[[1;5C' forward-word

    # Bind Ctrl+A and Ctrl+E to beginning and end of line
    bindkey '^A' beginning-of-line
    bindkey '^E' end-of-line

    # Bind Ctrl+U to clear line
    bindkey '^U' backward-kill-line

    #  Edit long commands with Ctrl+X followed by Ctrl+E (same as bash)
    autoload -U edit-command-line
    zle -N edit-command-line
    bindkey '^xe' edit-command-line
    bindkey '^x^e' edit-command-line
  '';

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
     elisa
     konsole
     ark
     kate
     kwallet
     kwrited
     kwalletmanager
     kde-gtk-config
     polkit-kde-agent-1
     qrca
  ];

}
