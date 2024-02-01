{ pkgs, lib, ... }: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp-cmdline
      cmp-nvim-ultisnips
      {
        plugin = nvim-cmp;
        type = "lua";
        config = /* lua */''
          local cmp = require'cmp'
          local types = require'cmp.types'

          cmp.setup({
            completion = {
              keyword_length = 0,
              autocomplete = false,
            },
            snippet = {
              expand = function(args)
                vim.fn["UltiSnips#Anon"](args.body)
              end,
            },
            mapping = cmp.mapping.preset.insert({
              ['<C-u>'] = cmp.mapping.scroll_docs(-4),
              ['<C-d>'] = cmp.mapping.scroll_docs(4),
              ['<C-o>'] = cmp.mapping.complete(),
              ['<C-e>'] = cmp.mapping.abort(),
              ['<CR>'] = cmp.mapping.confirm({ select = true }),
            }),
            sources = cmp.config.sources({
              { name = 'nvim_lsp' },
              { name = 'ultisnips' },
              { name = 'path' },
              { name = 'orgmode' },
            }, {
              { name = 'buffer' },
            })
          })

        cmp.setup.cmdline(':', {
            completion = {
              keyword_length = 0,
              autocomplete = {
                types.cmp.TriggerEvent.TextChanged,
              },
            },
          mapping = cmp.mapping.preset.cmdline(),
          sources = cmp.config.sources({
            { name = 'path' },
            { name = 'buffer' }
          }, {
            {
              name = 'cmdline',
              option = {
                ignore_cmds = { 'Man', '!' }
              }
            }
          })
        })
        '';
      }
    ];
  };
}
