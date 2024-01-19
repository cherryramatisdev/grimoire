{ pkgs, lib, ... }: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp-nvim-ultisnips
      {
        plugin = nvim-cmp;
        type = "lua";
        config = /* lua */''
          local cmp = require'cmp'

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
            }, {
              { name = 'buffer' },
              { name = 'path' },
            })
          })

        '';
      }
    ];
  };
}
