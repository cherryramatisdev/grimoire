{ pkgs, lib, ... }:
let
  nvimFilesPath = "~/Repos/grimoire/modules/home-manager/settings/nvim/files";
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
  imports = [
    ./plugins/lsp.nix
    ./plugins/treesitter.nix
    ./plugins/completion.nix
    ./plugins/colors.nix
    ./plugins/writing.nix
    ./plugins/terminal.nix
  ];
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = false;
    vimdiffAlias = true;
    extraLuaConfig = /* lua */''
      vim.cmd [[
      set runtimepath^=${nvimFilesPath}
      set runtimepath+=${nvimFilesPath}/after
      set runtimepath+=${nvimFilesPath}/queries
      ]]
    '';
    plugins = with pkgs.vimPlugins; [
      file-line
      vim-table-mode
      vim-repeat
      vim-surround
      vim-rhubarb
      vim-rsi
      plenary-nvim
      vim-visual-multi
      {
        plugin = comment-nvim;
        type = "lua";
        config = /* lua */''
          require('Comment').setup()
        '';
      }
      (fromGitHub "e1ebfa946d2530077ca1406a52494886ca66535b" "main" "cherryramatisdev/windows.vim")
      {
        plugin = telescope-nvim;
        type = "lua";
        config = /* lua */''
              require('telescope').setup{
                  defaults = {
                      mappings = {
                          i = {
                                  ["<esc>"] = "close",
                                  ["<C-h>"] = "which_key",
                                  ["<c-l>"] = "to_fuzzy_refine"
                          }
                      }
                  },
              }

          local builtin = require('telescope.builtin')
          vim.keymap.set('n', '<c-p>', builtin.find_files, {})
          vim.keymap.set('n', '<C-f>', builtin.live_grep, {})
        '';
      }
      {
        plugin = oil-nvim;
        type = "lua";
        config = /* lua */''
          	require'oil'.setup{}
          	vim.keymap.set('n', '-', require'oil'.open)
          	'';
      }
      {
        plugin = ultisnips;
        type = "viml";
        config = /* vim */''
          	  let g:UltiSnipsSnippetDirectories=[expand("${nvimFilesPath}/UltiSnips")]
          	  let g:UltiSnipsExpandTrigger="<tab>"
          	  let g:UltiSnipsJumpForwardTrigger="<tab>"
          	  let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
          	  let g:UltiSnipsEditSplit="vertical"
          	'';
      }
      {
        plugin = emmet-vim;
        type = "viml";
        config = /* vim */''
          let g:user_emmet_install_global = 0
          autocmd FileType html,typescript,typescriptreact,javascriptreact,css,heex EmmetInstall | imap <expr> <leader>e emmet#expandAbbrIntelligent("\<leader>e")
        '';
      }
      nvim-notify
      {
        plugin = noice-nvim;
        type = "lua";
        config = /* lua */''
          require("noice").setup({
            routes = {
                {
                    filter = { event = "notify", find = "No information available" },
                    opts = { skip = true }
                },
                {
                    filter = {
                      event = "msg_show",
                      kind = "",
                      find = "written",
                    },
                    opts = { skip = true },
               },
                 {
                    filter = {
                      event = "msg_show",
                      kind = "",
                      find = "yanked",
                    },
                    opts = { skip = true },
              },
                 {
                    filter = {
                      event = "msg_show",
                      kind = "",
                      find = "more lines",
                    },
                    opts = { skip = true },
              },
                 {
                    filter = {
                      event = "msg_show",
                      kind = "",
                      find = "more line",
                    },
                    opts = { skip = true },
              },
                 {
                    filter = {
                      event = "msg_show",
                      kind = "",
                      find = "fewer lines",
                    },
                    opts = { skip = true },
              },
            },
            lsp = {
              override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
              },
            },
            presets = {
              bottom_search = true, -- use a classic bottom cmdline for search
              command_palette = true, -- position the cmdline and popupmenu together
              long_message_to_split = true, -- long messages will be sent to a split
              inc_rename = false, -- enables an input dialog for inc-rename.nvim
              lsp_doc_border = true, -- add a border to hover docs and signature help
            },
          })
        '';
      }
    ];
  };
}
