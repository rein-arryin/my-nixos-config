{ config, lib, pkgs, pkgs-unstable, inputs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  boot = {

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
	  useOSProber = true;
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
	displayManager.sddm = {
	  enable = true;
	  wayland.enable = true;
  	};

	 pipewire = {
	   enable = true;
	   pulse.enable = true;
	   wireplumber.enable = true;
	};

	power-profiles-daemon.enable = true;
	gvfs.enable = true;
	udisks2.enable = true;
	tumbler.enable = true;
	upower.enable = true;
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
  programs.niri.enable = true;
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
     
     # Terminal
     alacritty

     # Terminal Utils
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

     # Audio
     pavucontrol

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

     # Wallpaper
     awww

     # Cursor Theme
     bibata-cursors     

     # Unstable
   ];

  environment.variables = {
     NIXOS_OZONE_WL = "1";
  };

  environment.shellAliases = {
     v = "nvim";
     sv = "sudo nvim";
     nrs = "sudo nixos-rebuild switch";
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

