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
      vim-repeat
      vim-surround
      vim-fugitive
      vim-rhubarb
      {
        plugin = fzf-vim;
        type = "lua";
        config = ''
          vim.keymap.set('n', '<c-p>', ':FZF<cr>')
          vim.keymap.set('n', '<c-f>', ':Rg')
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
        config = ''
          require'lspconfig'.tsserver.setup {}
          require'lspconfig'.nixd.setup {}

          vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
          vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
          vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
          vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

          vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('UserLspConfig', {}),
            callback = function(ev)
              -- Enable completion triggered by <c-x><c-o>
              vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
              vim.bo[ev.buf].tagfunc = 'v:lua.vim.lsp.tagfunc'

              local opts = { buffer = ev.buf }
              vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
              vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
              vim.cmd [[ command! Rename :lua vim.lsp.buf.rename ]]
              vim.cmd [[ command! Fixit :lua vim.lsp.buf.code_action ]]
              vim.cmd [[ command! References :lua vim.lsp.buf.references ]]
              vim.keymap.set('n', '<leader>f', function()
                vim.lsp.buf.format { async = true }
              end, opts)
            end,
          })
        '';
      }
      {
        plugin = (nvim-treesitter.withPlugins (p: [
          p.tree-sitter-vim
          p.tree-sitter-nix
          p.tree-sitter-lua
          p.tree-sitter-html
          p.tree-sitter-css
          p.tree-sitter-typescript
          p.tree-sitter-javascript
          p.tree-sitter-tsx
          p.tree-sitter-rust
          p.tree-sitter-ruby
          p.tree-sitter-vimdoc
          p.tree-sitter-query
        ]));
        type = "lua";
        config = ''
          	  require'nvim-treesitter.configs'.setup {
          	      highlight = {
          		enable = true,
          		additional_vim_regex_highlighting = false,
          	      },
          	    }
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
    ];
  };
}
