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
    enable = false;
    defaultEditor = false;
    viAlias = false;
    vimAlias = false;
    vimdiffAlias = false;
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
      vim-vinegar
      vim-repeat
      vim-surround
      vim-rhubarb
      vim-rsi
      plenary-nvim
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
    ];
  };
}
