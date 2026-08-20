{ config, pkgs, lib, ... }:

{
  # Kde Plasma
  services.desktopManager.plasma6.enable = true;

  environment.systemPackages = with pkgs.kdePackages; [
     plasma-integration
     kservice
  ];

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
     okular
  ];

  environment.etc."xdg/menus/applications.menu".source = 
    "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";
}
