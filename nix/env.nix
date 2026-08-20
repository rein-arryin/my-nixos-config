{ config, pkgs, lib, ... }:

{

  environment.variables = {
     NIXOS_OZONE_WL = "1";
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    LIBVA_DRIVER_NAME = "iHD";
    QT_QPA_PLATFORM = "wayland;xcb";
    #QT_QPA_PLATFORM = "kde";
  };  

  environment.shellAliases = {
     shutdown = "shutdown now";
     v = "nvim";
     sv = "doas nvim";
     nrs = "doas nixos-rebuild switch";
     nrs-flake = "cd /etc/nixos && doas nixos-rebuild switch --flake . && cd -";
     nfs = "doas nix flake update";
     nfu = "doas nix flake update nixpkgs nixpkgs-unstable";
     hms = "home-manager switch";
     svn = "doas nvim /etc/nixos";
     restart = "systemctl restart display-manager";
   };
}
