{ config, pkgs, lib, ... }:

{

  services = {
	 pipewire = {
	   enable = true;
           alsa.enable = true;
	   pulse.enable = true;
	   wireplumber.enable = true;
	 };

        # X11
        xserver.enable = true;

        # dwm
        xserver.windowManager.dwm.enable = true;

        gnome.gnome-keyring.enable = lib.mkForce false;
        logind.settings.Login.HandleLidSwitch = "suspend";

        teamviewer.enable = true;

        flatpak.enable = true;

	power-profiles-daemon.enable = true;
	gvfs.enable = true;
	udisks2.enable = true;
	tumbler.enable = true;
	upower.enable = true;
        mpd.enable = true;
  };

  virtualisation = {
    waydroid.enable = true;
    waydroid.package = pkgs.waydroid-nftables;
    libvirtd.enable = true;
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
  };  
}
