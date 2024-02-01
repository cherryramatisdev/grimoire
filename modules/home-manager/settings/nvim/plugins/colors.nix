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
                  vim.cmd('colorscheme rose-pine-moon')
              end,
              set_light_mode = function()
                  vim.api.nvim_set_option('background', 'light')
                  vim.cmd('colorscheme rose-pine-dawn')
              end,
          })
        '';
      }
      {
        plugin = rose-pine;
        type = "lua";
        config = /* lua */''
                    require("rose-pine").setup({
              variant = "auto", -- auto, main, moon, or dawn
              dark_variant = "main", -- main, moon, or dawn
              dim_inactive_windows = true,
              extend_background_behind_borders = true,
              enable = {
                  terminal = true,
                  legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
                  migrations = true, -- Handle deprecated options automatically
              },
              styles = {
                  bold = true,
                  italic = true,
                  transparency = false,
              },
              groups = {
                  border = "muted",
                  link = "iris",
                  panel = "surface",
                  error = "love",
                  hint = "iris",
                  info = "foam",
                  note = "pine",
                  todo = "rose",
                  warn = "gold",
                  git_add = "foam",
                  git_change = "rose",
                  git_delete = "love",
                  git_dirty = "rose",
                  git_ignore = "muted",
                  git_merge = "iris",
                  git_rename = "pine",
                  git_stage = "iris",
                  git_text = "rose",
                  git_untracked = "subtle",
                  h1 = "iris",
                  h2 = "foam",
                  h3 = "rose",
                  h4 = "gold",
                  h5 = "pine",
                  h6 = "foam",
              },
          })
        '';
      }
    ];
  };
}
