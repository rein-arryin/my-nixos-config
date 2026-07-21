{ pkgs, inputs, ... }:

{

imports = [
        inputs.qylock.nixosModules.default
];

services.displayManager.sddm = {
    enable = true;
    wayland = {
        enable = true;
        compositor = "kwin";
    };  

  settings.Theme = {
    CursorTheme = "Hackneyed";
    CursorSize = 24;
  };  
};  

programs.qylock = {
  enable = true;
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

