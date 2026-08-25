{ pkgs, inputs, ... }:

  let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
  in

{
  imports = 
    [
      inputs.spicetify-nix.nixosModules.spicetify
    ];

  programs.spicetify = {
    enable = true;
    enabledExtensions = with spicePkgs.extensions; [
      adblockify
    ];
    #theme = spicePkgs.themes.catppuccin;
    #colorScheme = "mocha";
    theme = spicePkgs.themes.tokyoNight;
    colorScheme = "Night";
   };

}   
