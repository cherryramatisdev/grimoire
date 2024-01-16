{ pkgs, lib, ... }: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    extraLuaConfig = ''
      vim.cmd [[
      set runtimepath^=~/Repos/grimoire/modules/home-manager/settings/nvim
      set runtimepath+=~/Repos/grimoire/modules/home-manager/settings/nvim/after
      ]]
    '';
    plugins = with pkgs.vimPlugins; [
      file-line
      vim-commentary
      vim-table-mode
      vim-repeat
      vim-surround
      vim-fugitive
      vim-rhubarb
      plenary-nvim
      {
        plugin = fidget-nvim;
        type = "lua";
        config = ''
          require("fidget").setup {}
        '';
      }
      {
        plugin = fzf-vim;
        type = "lua";
        config = ''
          vim.keymap.set('n', '<c-p>', ':FZF<cr>')
          vim.keymap.set('n', '<c-f>', ':Rg<space>')
        '';
      }
      {
        plugin = oil-nvim;
        type = "lua";
        config = ''
          	require'oil'.setup{}
          	vim.keymap.set('n', '-', ':Oil<cr>')
          	'';
      }
      {
        plugin = nvim-lspconfig;
        type = "lua";
        config = builtins.readFile ./nvim/plugins/lsp.lua;
      }
      {
        plugin = (nvim-treesitter.withPlugins (p: [
          hmts-nvim
          p.tree-sitter-vim
          p.tree-sitter-nix
          p.tree-sitter-haskell
          p.tree-sitter-lua
          p.tree-sitter-html
          p.tree-sitter-elixir
          p.tree-sitter-heex
          p.tree-sitter-css
          p.tree-sitter-typescript
          p.tree-sitter-javascript
          p.tree-sitter-jsdoc
          p.tree-sitter-tsx
          p.tree-sitter-rust
          p.tree-sitter-ruby
          p.tree-sitter-vimdoc
          p.tree-sitter-query
          p.tree-sitter-gitcommit
        ]));
        type = "lua";
        config = ''
          require'nvim-treesitter.configs'.setup {
              highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
              },
              indent = {
                  enable = true,
              }
            }

            vim.cmd [[
            set foldmethod=expr
            set foldexpr=nvim_treesitter#foldexpr()
            set nofoldenable
            ]]
        '';
      }
      {
        plugin = ultisnips;
        type = "lua";
        config = ''
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
        config = ''
          let g:user_emmet_install_global = 0
          autocmd FileType html,typescript,typescriptreact,javascriptreact,css EmmetInstall | imap <expr> <leader>e emmet#expandAbbrIntelligent("\<leader>e")
        '';
      }
    ];
  };
}
