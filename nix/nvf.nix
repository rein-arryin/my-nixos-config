{ pkgs, ... }:

{
    config.vim = {
      viAlias = true;
      vimAlias = true;
      
      theme = {
        enable = true;
        name = "tokyonight";
        style = "night";
      };

      statusline.lualine.enable = true;
      telescope.enable = true;
      autocomplete.nvim-cmp.enable = true;
      clipboard.enable = true;

      # Restore cursor position to last opened line
      luaConfigPost = ''
        vim.api.nvim_create_autocmd("BufReadPost", {
          pattern = "*",
          callback = function()
            local last_pos = vim.api.nvim_buf_get_mark(0, '"')
            local line_count = vim.api.nvim_buf_line_count(0)
            if last_pos[1] > 0 and last_pos[1] <= line_count then
              pcall(vim.api.nvim_win_set_cursor, 0, last_pos)
            end
          end,
        })
      '';

      languages = {
        enableTreesitter = true;

        nix.enable = false;
        rust.enable = true;
      };

      luaConfigRC.my_aliases = ''
        vim.api.nvim_create_user_command("Wq", "wq", {})
        vim.api.nvim_create_user_command("WQ", "wq", {})
        vim.api.nvim_create_user_command("W", "w", {})
        vim.api.nvim_create_user_command("Q", "q", {})
        vim.api.nvim_create_user_command("Q1", "q!", {})
      '';
    };
}
