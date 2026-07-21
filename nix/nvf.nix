{ pkgs, lib, ... }:

{
  vim = {
    theme = {
      enable = true;
      name = "tokyonight";
      style = "moon";
    };

    statusline.lualine.enable = true;
    telescope.enable = true;
    autocomplete.nvim-cmp.enable = true;
    clipboard.enable = true;

    languages = {
      enableLSP = true;
      enableTreesitter = true;

      nix.enable = false;
      ts.enable = true;
      rust.enable = true;                    
    };   
  luaConfigRC.my_aliases = ''
    vim.api.nvim_create_user_command("Wq", "wq", {})  
    vim.api.nvim_create_user_command("WQ", "wq", {})  
    vim.api.nvim_create_user_command("WQ", "wq", {})
    vim.api.nvim_create_user_command("W", "w", {})
    vim.api.nvim_create_user_command("Q", "q", {})
    vim.api.nvim_create_user_command("Q1", "q!", {})
  '';
 };               
}  
