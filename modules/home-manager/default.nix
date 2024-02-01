{ pkgs, ... }: {
  imports = [
    ./settings/tmux.nix
    ./settings/bash.nix
    ./settings/nvim/nvim.nix
    ./settings/alacritty.nix
    ./settings/git.nix
    ./settings/starship.nix
    ./settings/wezterm.nix
  ];

  home = {
    username = "cherry";
    homeDirectory = "/Users/cherry";
    packages = with pkgs; [
# LSPs
      nixd
      gopls

# Shells & Utils
      bashInteractive
      bash-completion
      universal-ctags
      eza
      delta
      coreutils-full
      reattach-to-user-namespace
      lazygit
      tree
      jq
      ripgrep
      fd
      bat
      perl538Packages.PerlTidy
      gitmux
      asdf-vm
      asciiquarium

# Desktop apps
      discord
      karabiner-elements
      obsidian
    ];
  };

  programs = {
    bat = {
      enable = true;
    };
    fzf = {
      enable = true;
      enableBashIntegration = true;
    };
  };

  home.file.".config/karabiner/karabiner.json".source = ./settings/karabiner.json;
  home.file."reviewers".source = ./settings/reviewers;
  home.file.".irbrc".source = ./settings/irbrc;
  home.file.".exrc".source = ./settings/exrc;
  home.file."Scripts" = {
    source = ./settings/scripts;
    recursive = true;
  };

  home.stateVersion = "23.11";
}
