{ config, lib, ... }:

{

  boot = {

        kernelParams = [ "quiet" "splash" "mem_sleep_default=deep" ];
        #kernelParams = [ "splash" "mem_sleep_default=deep" ];
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
            menuentry "Arch Linux" {
              search --set=root --fs-uuid 4058-F3D7
              linux /vmlinuz-linux-zen root=UUID=615499bb-727c-4465-ac66-9e0bf6faa0b7 rw quiet splash
              initrd /initramfs-linux-zen.img
              }
          '';
        };
      };
    };

}
