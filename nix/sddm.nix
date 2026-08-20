{ inputs, lib, ... }:

{

  imports = [
    inputs.qylock.nixosModules.default
    inputs.silentSDDM.nixosModules.default
  ];

  services.displayManager.sddm = {
      enable = true;
      wayland = {
          enable = lib.mkForce true;
          compositor = "kwin";
      };  

  settings.Theme = {
    CursorTheme = "Hackneyed";
    CursorSize = 24;
    };  
  };  

  # Theme
  
  # SilentSDDM
  programs.silentSDDM = {
    enable = true;
    theme = "default";
  };

  # Qylock
  programs.qylock = {
    enable = false;
    theme = "windows_7";
    #sddm.enable = true;
    #quickshell.enable = true;

     themeOptions = {
       terraria.backgroundMode = "time";
       Genshin.backgroundMode = "time";
       clockwork.orbital = { themeMode = "dark"; enableWindup = true; };
       osu.gameMode = "menu";
     };
  };
} 

