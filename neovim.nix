{ pkgs, inputs, ... }:

{
  imports = 
    [
      inputs.nvf.nixosModules.default
    ];

   programs.neovim = {
      enable = true;
   };   

    programs.nvf = {
      enable = true;
      settings = {
        vim = { 
          viAlias = false;
	  vimAlias = true;
          theme = {
             enable = true;
	     name = "tokyonight";
	     style = "night";
	     transparent = false;
	   };
        };  
     };
  }; 
}   
