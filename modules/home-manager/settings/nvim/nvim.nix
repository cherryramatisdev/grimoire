{ pkgs, ... }: 
let
    nvimFilesPath = "~/Repos/grimoire/modules/home-manager/settings/nvim/files";
in
{
  imports = [
    ./plugins/lsp.nix
    ./plugins/treesitter.nix
    ./plugins/completion.nix
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
      ]]
    '';
    plugins = with pkgs.vimPlugins; [
      file-line
      vim-commentary
      vim-table-mode
      vim-repeat
      vim-surround
      vim-fugitive
      vim-rhubarb
      plenary-nvim
      {
        plugin = fzf-vim;
        type = "viml";
        config = /* vim */''
            nnoremap <c-p> :FZF<cr>
            nnoremap <c-f> :Rg<space>
        '';
      }
      {
        plugin = oil-nvim;
        type = "lua";
        config = /* lua */''
          	require'oil'.setup{}
          	vim.keymap.set('n', '-', ':Oil<cr>')
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
          autocmd FileType html,typescript,typescriptreact,javascriptreact,css EmmetInstall | imap <expr> <leader>e emmet#expandAbbrIntelligent("\<leader>e")
        '';
      }
    ];
  };
}
