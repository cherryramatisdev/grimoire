{ pkgs, ... }: {
  imports = [
    ./settings/tmux.nix
    ./settings/bash.nix
    ./settings/nvim.nix
    ./settings/alacritty.nix
    ./settings/git.nix
  ];

  home = {
    username = "cherry";
    homeDirectory = "/Users/cherry";
    packages = with pkgs; [
      nixd
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
      go
      gitmux
      asdf-vm
      discord
      karabiner-elements
    ];
  };

  programs = {
    starship = {
      enable = true;
      settings = {
        scan_timeout = 10;
        add_newline = false;
        character = {
          success_symbol = "[🍒](bold green)";
          error_symbol = "[🍒](bold red)";
        };
        custom.gh_profile = {
          command = "gh_current_active_account";
          symbol = "🎋 ";
          style = "bold white";
          when = true;
        };
        package = {
          disabled = true;
        };
      };
    };

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
