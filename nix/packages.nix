{ config, lib, pkgs, pkgs-unstable, inputs, nvim, ... }:

{
# Packages
  programs.zsh.enable = true;
  programs.kdeconnect.enable = true;
  programs.xfconf.enable = true;
  programs.dconf.enable = true;

  # Steam
  programs.steam = {
    enable = true;
  };

  programs.thunar = {
    enable = true;
    plugins = with pkgs; [
      thunar-archive-plugin
      thunar-volman
    ];
  };

  security.polkit.enable = true;
  security.audit.enable = true;

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
     unzip
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
   ];
}

