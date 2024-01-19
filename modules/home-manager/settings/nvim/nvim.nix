{ pkgs, ... }: {
  imports = [
    ./plugins/lsp.nix
    ./plugins/treesitter.nix
    ./plugins/completion.nix
  ];
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = false;
    vimdiffAlias = true;
    extraLuaConfig = /* lua */''
      vim.cmd [[
      set runtimepath^=~/Repos/grimoire/modules/home-manager/settings/nvim/files
      set runtimepath+=~/Repos/grimoire/modules/home-manager/settings/nvim/files/after
      ]]
    '';
    plugins = with pkgs.vimPlugins; [
      file-line
      vim-commentary
      vim-table-mode
      vim-repeat
      vim-surround
      vim-go
      vim-fugitive
      vim-rhubarb
      plenary-nvim
      {
        plugin = fzf-vim;
        type = "lua";
        config = /* lua */''
          vim.keymap.set('n', '<c-p>', ':FZF<cr>')
          vim.keymap.set('n', '<c-f>', ':Rg<space>')
        '';
      }
      {
        plugin = oil-nvim;
        type = "lua";
        config = /* lua */''
          	require'oil'.setup{}
          	vim.keymap.set('n', '-', ':Oil<cr>')
          	'';
      }
      {
        plugin = ultisnips;
        type = "lua";
        config = /* lua */''
          	  vim.g.UltiSnipsSnippetDirectories={"~/Repos/grimoire/modules/home-manager/settings/nvim/UltiSnips"}
          	  vim.g.UltiSnipsExpandTrigger="<tab>"
          	  vim.g.UltiSnipsJumpForwardTrigger="<tab>"
          	  vim.g.UltiSnipsJumpBackwardTrigger="<s-tab>"
          	  vim.g.UltiSnipsEditSplit="vertical"
          	'';
      }
      {
        plugin = emmet-vim;
        type = "viml";
        config = /* vim */''
          let g:user_emmet_install_global = 0
          autocmd FileType html,typescript,typescriptreact,javascriptreact,css EmmetInstall | imap <expr> <leader>e emmet#expandAbbrIntelligent("\<leader>e")
        '';
      }
    ];
  };
}
