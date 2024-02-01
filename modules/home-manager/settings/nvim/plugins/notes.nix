{ pkgs, lib, ... }: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      {
        plugin = orgmode;
        type = "lua";
        config = /* lua */''
          require('orgmode').setup_ts_grammar()

          require('orgmode').setup({
            org_agenda_files = '~/org/**/*',
            org_default_notes_file = '~/org/refile.org',
          })
        '';
      }
    ];
  };
}
