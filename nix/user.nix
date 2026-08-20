{ config, pkgs, ... }:

{ 
   users.users.neo = {
     isNormalUser = true;
     shell = pkgs.bashInteractive;
     extraGroups = [
     "wheel"
     "adbusers"
     "networkmanager"
     "storage"
     "plugdev"
     "disk"
     "libvirtd"
     ]; 
   };
}   
