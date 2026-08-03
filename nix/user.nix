{ config, ... }:

{ 
   users.users.neo = {
     isNormalUser = true;
     shell = pkgs.zsh;
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
