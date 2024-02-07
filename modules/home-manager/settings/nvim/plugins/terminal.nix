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
            plugin = toggleterm-nvim;
            type = "lua";
            config = /* lua */''
                require("toggleterm").setup({
                    direction = 'tab'
                })

                vim.cmd [[
                    " set
                    nnoremap <leader>g <cmd>tabnew term://lazygit<cr>
                    autocmd TermEnter term://*toggleterm#*
                          \ tnoremap <silent><leader>a <Cmd>exe v:count1 . "ToggleTerm"<CR>

                    " By applying the mappings this way you can pass a count to your
                    " mapping to open a specific window.
                    " For example: 2<leader>a will open terminal 2
                    nnoremap <silent><leader>a <Cmd>exe v:count1 . "ToggleTerm"<CR>
                    inoremap <silent><leader>a <Esc><Cmd>exe v:count1 . "ToggleTerm"<CR>
                ]]
            '';
          }
      (fromGitHub "c3d253864784fdb33cc5013b7afc4f0910e2cac3" "master" "nikvdp/neomux")
    ];
  };
}
