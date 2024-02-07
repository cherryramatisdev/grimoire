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
                vim.cmd [[
                " Automatically close terminal when process ends
                autocmd TermClose * execute 'bdelete! ' . expand('<abuf>')
                ]]

                require("toggleterm").setup({
                    direction = 'tab'
                })

                vim.keymap.set('n', '<leader>g', '<cmd>tabnew term://lazygit<cr>')
                vim.keymap.set({'t', 'n', 'i'}, '<leader>a', '<Cmd>exe v:count1 .. "ToggleTerm"<CR>', { silent = true })
            '';
          }
      (fromGitHub "c3d253864784fdb33cc5013b7afc4f0910e2cac3" "master" "nikvdp/neomux")
    ];
  };
}
