{ config, lib, pkgs, ... }:

{

  boot = {

        kernelParams = [ "quiet" "splash" "mem_sleep_default=deep" ];
        kernelPackages = pkgs.linuxPackages_latest; 
        #kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest; # Latest Cachyos Kernel
        # kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-bore; # Cachyos Kernel BORE
        #extraModprobeConfig = ''
        #options bluetooth disable_ertm=Y
        #'';

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
          '';
        };
      };
    };

}
