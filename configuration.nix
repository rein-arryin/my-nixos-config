{ config, lib, pkgs, pkgs-unstable, inputs, nvim, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  boot = {

	kernelParams = [ "quiet" "splash" "mem_sleep_default=deep" ];
        extraModprobeConfig = ''
  	options bluetooth disable_ertm=Y
	'';

    loader = {
  	timeout = 15;

	efi = {	
	  canTouchEfiVariables = true;
	  efiSysMountPoint = "/boot/efi";
        };

  	grub = {
	  enable = true;
	  efiSupport = true;
	  device = "nodev";
	  useOSProber = false;
          splashImage = ./shark.png;
          extraEntries = ''
            menuentry "Windows" {
              search --set=root --fs-uuid E869-3F4C
              chainloader /EFI/Microsoft/Boot/bootmgfw.efi
              }
            menuentry "Linux Mint" {
              search --set=root --fs-uuid fef8ab95-1fc6-49a5-8ef8-e09c5d9b008e
              linux /boot/vmlinuz-6.17.0-29-generic root=UUID=fef8ab95-1fc6-49a5-8ef8-e09c5d9b008e rw quiet splash
              initrd /boot/initrd.img-6.17.0-29-generic
              }
            menuentry "Arch Linux" {
              search --set=root --fs-uuid 4058-F3D7
              linux /vmlinuz-linux-zen root=UUID=615499bb-727c-4465-ac66-9e0bf6faa0b7 rw quiet splash
              initrd /initramfs-linux-zen.img
              }
          '';  
        };
      };
    };

  hardware.bluetooth = {
     enable = true;
     powerOnBoot = true;
    };

  nix.gc = {
     automatic = true;
     dates = "weekly";
     persistent = true;
     options = "--delete-older-than 14d";
    };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  
  networking.hostName = "nixos"; 

  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Jakarta";

  services = {  
	 pipewire = {
	   enable = true;
	   pulse.enable = true;
	   wireplumber.enable = true;
	 };
        
          xserver.desktopManager = {
            cinnamon.enable = true;
          };  

        gnome.gnome-keyring.enable = lib.mkForce false;
        logind.settings.Login.HandleLidSwitch = "suspend";

	power-profiles-daemon.enable = true;
	gvfs.enable = true;
	udisks2.enable = true;
	tumbler.enable = true;
	upower.enable = true;
  };

  virtualisation = {
    waydroid.enable = true;
    waydroid.package = pkgs.waydroid-nftables;
  };  
  
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
   };              

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

   users.users.neo = {
     isNormalUser = true;
     shell = pkgs.zsh;
     extraGroups = [ "wheel" "adbusers" "networkmanager" "storage" "plugdev" "disk" ]; 
     packages = with pkgs; [
       tree
     ];
   };

  programs.zsh.enable = true;
  programs.waybar.enable = false;
  programs.kdeconnect.enable = true;
  programs.xfconf.enable = true;

  programs.thunar = {
    enable = true;
    plugins = with pkgs; [
      thunar-archive-plugin
      thunar-volman
    ];
  };  

  security.polkit.enable = true;

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
     xev           

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
   ];

  environment.variables = {
     NIXOS_OZONE_WL = "1";
  };

  environment.shellAliases = {
     shutdown = "shutdown now";
     v = "nvim";
     sv = "sudo nvim";
     nrs = "sudo nixos-rebuild switch";
     nrs-flake = "sudo nixos-rebuild switch --flake .";
     hms = "home-manager switch";
     svn = "sudo nvim /etc/nixos/configuration.nix";
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


  fonts.packages = with pkgs; [
     font-awesome
     jetbrains-mono
     nerd-fonts.jetbrains-mono
     nerd-fonts.fira-code
  ];

  systemd.user.services.polkit-gnome-authentication-agent-1 = {
     description = "polkit-gnome-authentication-agent-1";

     wantedBy = [ "graphical-session.target" ];

     serviceConfig = {
        ExecStart = 
	  "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
           Restart = "on-failure";
	   };
      };


  system.stateVersion = "25.11";

}

