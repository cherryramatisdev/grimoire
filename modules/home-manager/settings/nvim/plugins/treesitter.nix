{ pkgs, lib, ... }: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      {
        plugin = (nvim-treesitter.withPlugins (p: [
          hmts-nvim
          p.tree-sitter-vim
          p.tree-sitter-nix
          p.tree-sitter-haskell
          p.tree-sitter-lua
          #p.tree-sitter-go
          p.tree-sitter-templ
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
          p.tree-sitter-diff
          p.tree-sitter-prisma
        ]));
        type = "lua";
        config = /* lua */''
           vim.filetype.add({
               extension = {
                   templ = "templ",
               },
           })

          require'nvim-treesitter.configs'.setup {
              highlight = {
                enable = true,
                additional_vim_regex_highlighting = {'org'},
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
    ];
  };
}
