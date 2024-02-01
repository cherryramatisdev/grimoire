{ pkgs, lib, ... }:
let
  fromGitHub = rev: ref: repo: pkgs.vimUtils.buildVimPlugin {
    pname = "${lib.strings.sanitizeDerivationName repo}";
    version = ref;
    src = builtins.fetchGit {
      url = "https://github.com/${repo}.git";
      ref = ref;
      rev = rev;
    };
  };
in
{
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      {
        plugin = fromGitHub "a8f26d3d6a0faf533afb840816a6d9ac6a1fcbea" "main" "dmmulroy/tsc.nvim";
        type = "lua";
        config = /* lua */''
          require('tsc').setup()
        '';
      }
      {
        plugin = neodev-nvim;
        type = "lua";
        config = /* lua */''
          require'neodev'.setup {}
        '';
      }
      {
        plugin = mason-nvim;
        type = "lua";
        config = /* lua */''
          require("mason").setup()
        '';
      }
      {
        plugin = dressing-nvim;
        type = "lua";
        config = /* lua */''
          require("dressing").setup({
              input = {
                -- Set to false to disable the vim.ui.input implementation
                enabled = true,
                -- Default prompt string
                default_prompt = "Input",
                -- Trim trailing `:` from prompt
                trim_prompt = true,
                -- Can be 'left', 'right', or 'center'
                title_pos = "left",
                -- When true, <Esc> will close the modal
                insert_only = true,
                -- When true, input will start in insert mode.
                start_in_insert = true,
                -- These are passed to nvim_open_win
                border = "rounded",
                -- 'editor' and 'win' will default to being centered
                relative = "cursor",
                -- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
                prefer_width = 40,
                width = nil,
                -- min_width and max_width can be a list of mixed types.
                -- min_width = {20, 0.2} means "the greater of 20 columns or 20% of total"
                max_width = { 140, 0.9 },
                min_width = { 20, 0.2 },
                buf_options = {},
                win_options = {
                  -- Disable line wrapping
                  wrap = false,
                  -- Indicator for when text exceeds window
                  list = true,
                  listchars = "precedes:…,extends:…",
                  -- Increase this for more context when text scrolls off the window
                  sidescrolloff = 0,
                },
                -- Set to `false` to disable
                mappings = {
                  n = {
                    ["<Esc>"] = "Close",
                    ["<CR>"] = "Confirm",
                  },
                  i = {
                    ["<C-c>"] = "Close",
                    ["<CR>"] = "Confirm",
                    ["<C-p>"] = "HistoryPrev",
                    ["<C-n>"] = "HistoryNext",
                  },
                },
                get_config = nil,
              },
              select = {
                enabled = true,
                -- Priority list of preferred vim.select implementations
                backend = { "telescope" },
                -- Trim trailing `:` from prompt
                trim_prompt = true,
                -- Options for telescope selector
                telescope = require('telescope.themes').get_dropdown({winblend = 10, previewer = false,...})
              },
            })
        '';
      }
      {
        plugin = typescript-tools-nvim;
        type = "lua";
        config = /* lua */''
          require("typescript-tools").setup {
             settings = {
               -- spawn additional tsserver instance to calculate diagnostics on it
               separate_diagnostic_server = true,
               -- "change"|"insert_leave" determine when the client asks the server about diagnostic
               publish_diagnostic_on = "insert_leave",
               -- array of strings("fix_all"|"add_missing_imports"|"remove_unused"|
               -- "remove_unused_imports"|"organize_imports") -- or string "all"
               -- to include all supported code actions
               -- specify commands exposed as code_actions
               expose_as_code_action = "all",
               -- string|nil - specify a custom path to `tsserver.js` file, if this is nil or file under path
               -- not exists then standard path resolution strategy is applied
               tsserver_path = nil,
               -- specify a list of plugins to load by tsserver, e.g., for support `styled-components`
               -- (see 💅 `styled-components` support section)
               -- npm i -g @styled/typescript-styled-plugin typescript-styled-plugin
               tsserver_plugins = {"@styled/typescript-styled-plugin"},
               -- this value is passed to: https://nodejs.org/api/cli.html#--max-old-space-sizesize-in-megabytes
               -- memory limit in megabytes or "auto"(basically no limit)
               tsserver_max_memory = "auto",
               -- described below
               tsserver_format_options = {},
               tsserver_file_preferences = {},
               -- locale of all tsserver messages, supported locales you can find here:
               -- https://github.com/microsoft/TypeScript/blob/3c221fc086be52b19801f6e8d82596d04607ede6/src/compiler/utilitiesPublic.ts#L620
               tsserver_locale = "en",
               -- mirror of VSCode's `typescript.suggest.completeFunctionCalls`
               complete_function_calls = false,
               include_completions_with_insert_text = true,
               -- CodeLens
               -- WARNING: Experimental feature also in VSCode, because it might hit performance of server.
               -- possible values: ("off"|"all"|"implementations_only"|"references_only")
               code_lens = "off",
               -- by default code lenses are displayed on all referencable values and for some of you it can
               -- be too much this option reduce count of them by removing member references from lenses
               disable_member_code_lens = false,
               -- JSXCloseTag
               -- WARNING: it is disabled by default (maybe you configuration or distro already uses nvim-ts-autotag,
               -- that maybe have a conflict if enable this feature. )
               jsx_close_tag = {
                   enable = true,
                   filetypes = { "javascriptreact", "typescriptreact" },
               }
             },
           } 
        '';
      }
      {
        plugin = nvim-lspconfig;
        type = "lua";
        config = /* lua */''
          local capabilities = require('cmp_nvim_lsp').default_capabilities()

          require'lspconfig'.nixd.setup { capabilities = capabilities }
          require'lspconfig'.rust_analyzer.setup { capabilities = capabilities }
          require'lspconfig'.gopls.setup { capabilities = capabilities }
          require'lspconfig'.lua_ls.setup { capabilities = capabilities,
              settings = {
                  Lua = {
                      completion = {
                          callSnippet = "Replace"
                      }
                  }
              }
          }
          require'lspconfig'.elixirls.setup {
              capabilities = capabilities,
              cmd = { vim.fn.expand('~/.local/share/nvim/mason/packages/elixir-ls/language_server.sh') }
          }
          require'lspconfig'.hls.setup { capabilities = capabilities }

          vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
          vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
          vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
          vim.keymap.set('n', '<leader>q', vim.diagnostic.setqflist)

          vim.api.nvim_create_autocmd('LspAttach', {
              group = vim.api.nvim_create_augroup('UserLspConfig', {}),
              callback = function(ev)
                  -- Enable completion triggered by <c-x><c-o>
                  vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
                  vim.bo[ev.buf].tagfunc = 'v:lua.vim.lsp.tagfunc'

                  local opts = { buffer = ev.buf }
                  vim.keymap.set('i', '<C-o>', '<c-x><c-o>', opts)
                  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                  vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', opts)
                  vim.keymap.set('n', 'rn', vim.lsp.buf.rename, opts)
                  vim.keymap.set({'n', 'v'}, 'ga', vim.lsp.buf.code_action, opts)
                  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)

                  vim.cmd [[ command! Rename :lua vim.lsp.buf.rename() ]]
                  vim.cmd [[ command! Fixit :lua vim.lsp.buf.code_action() ]]
                  vim.cmd [[ command! References :lua vim.lsp.buf.references() ]]

                  local client = vim.lsp.get_active_clients()[1]

                  if client and client.server_capabilities.documentFormattingProvider then
                      vim.keymap.set('n', '<leader>f', function()
                          vim.lsp.buf.format { async = true }
                      end, opts)
                  end
              end,
          })
        '';
      }
    ];
  };
}
