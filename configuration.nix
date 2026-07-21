{ config, lib, inputs, ... }:

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
    ];

  nix.gc = {
     automatic = true;
     dates = "weekly";
     persistent = true;
     options = "--delete-older-than 14d";
    };

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  networking.hostName = "nixos"; 
  networking.networkmanager.enable = true;
  time.timeZone = "Asia/Jakarta";

  hardware.bluetooth = {
     enable = true;
     powerOnBoot = true;
    };  

   users.users.neo = {
     isNormalUser = true;
     shell = pkgs.zsh;
     extraGroups = [ "wheel" "adbusers" "networkmanager" "storage" "plugdev" "disk" ]; 
     packages = with pkgs; [
       tree
     ];
   };

  system.stateVersion = "25.11";

}
