{ config, pkgs, pkgs-unstable, inputs, nvim, ... }:

{
  # Packages
  programs = {
    zsh.enable = true;
    kdeconnect.enable = true;
    xfconf.enable = true;
    dconf.enable = true;
    steam.enable = true; # Steam
    virt-manager.enable = true; #KVM
  };  

  # Thunar
  programs.thunar = {
    enable = true;
    plugins = with pkgs; [
      thunar-archive-plugin
      thunar-volman
    ];
  };


  environment.systemPackages = with pkgs; [

     #Text Editor
     vim
     nvim

     # Terminal
     alacritty
     ghostty

     # Terminal Utils
     blueman
     efibootmgr
     fastfetch
     wget
     zip
     exfatprogs
     android-tools
     gcc
     gdb
     grim
     swappy
     slurp
     imagemagick
     cmake
     gnumake
     bat

     # Audio
     pavucontrol
     pulseaudio
     playerctl

     # Browser
     firefox

     # File Manager
     onlyoffice-desktopeditors

     # Environtment
     brightnessctl
     mpv
     git
     scrcpy
     swaybg
     xwayland-satellite
     xwayland
     wl-clipboard
     polkit_gnome
     wlr-randr

     # Wallpaper
     awww

     # Cursor Theme
     bibata-cursors
     hackneyed

     # Unstable

     # Minecraft
     temurin-bin-21
     steam-run

     # Thunar
     gnome.gvfs
     xarchiver
     unzip
     unrar
     p7zip
     gnome-themes-extra
   ];
}

