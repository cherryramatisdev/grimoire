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
        plugin = (fromGitHub "76e8d40d1e1544bae430f739d827391cbcb42fcc" "master" "f-person/auto-dark-mode.nvim");
        type = "lua";
        config = /* lua */''
          local auto_dark_mode = require('auto-dark-mode')

          auto_dark_mode.setup({
              update_interval = 1000,
              set_dark_mode = function()
                  vim.api.nvim_set_option('background', 'dark')
                  vim.cmd('colorscheme tokyonight-night')
              end,
              set_light_mode = function()
                  vim.api.nvim_set_option('background', 'light')
                  vim.cmd('colorscheme tokyonight-day')
              end,
          })
        '';
      }
      tokyonight-nvim
    ];
  };
}
