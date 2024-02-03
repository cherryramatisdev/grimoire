{ pkgs, lib, ... }: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      vim-pencil
      {
        plugin = twilight-nvim;
        type = "lua";
        config = /* lua */''
          require'twilight'.setup {}
        '';
      }
      {
        plugin = zen-mode-nvim;
        type = "lua";
        config = /* lua */''
          require'zen-mode'.setup {}
        '';
      }
    ];
  };
}
