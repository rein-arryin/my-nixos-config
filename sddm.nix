{ pkgs, ... }:

{

imports = [
        inputs.qylock.nixosModules.default
];

services.displayManager.sddm  = {
  enable = true;
  wayland.enable = true;
};  

programs.qylock = {
  enable = true;
  theme = "nier-automata";
  sddm.enable = true;
  quickshell.enable = true;

   themeOptions = {
     terraria.backgroundMode = "time";
     Genshin.backgroundMode = "time";
     clockwork.orbital = { themeMode = "dark"; enableWindup = true; };
     osu.gameMode = "menu";
   };
 };
} 

