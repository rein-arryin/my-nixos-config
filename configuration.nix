{ config, pkgs, lib, inputs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ./boot/boot.nix
      ./nix/env.nix
      ./nix/fonts.nix
      ./nix/packages.nix
      ./nix/polkit.nix
      ./nix/services.nix
      ./nix/user.nix
      ./nix/hardware.nix
      ./nix/security.nix
      ./nix/fstab.nix
    ];

  time.timeZone = "Asia/Jakarta";

  nix = {
    gc = {
       automatic = true;
       dates = "weekly";
       persistent = true;
       options = "--delete-older-than 14d";
    };

    settings.experimental-features = [ "nix-command" "flakes" ];
  };
  
  networking = {
    hostName = "nixos"; 
    networkmanager.enable = true;
  };

  nixpkgs = {
    overlays = [ inputs.nix-cachyos-kernel.overlays.pinned ];
    config.allowUnfree = true;
  };  

  system.stateVersion = "25.11";
}
