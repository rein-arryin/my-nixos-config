{ config, pkgs, pkgs-unstable, inputs, nvim, ... }:

{
  # Packages
  programs = {
    zsh.enable = true;
    kdeconnect.enable = true;
    steam.enable = true; # Steam
    virt-manager.enable = true; #KVM
  };  

  # Thunar
  programs.thunar = {
    enable = false;
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
     cmake
     gnumake
     bat

     # Audio
     pavucontrol
     pulseaudio

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
     unzip
     unrar
     p7zip
     gnome-themes-extra
   ];
}

