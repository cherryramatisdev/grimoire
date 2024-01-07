{ pkgs, ... }: {
    imports = [
        ./settings/tmux.nix
        ./settings/bash.nix
    ];

    home = {
        username = "cherry";
        homeDirectory = "/Users/cherry";
        packages = with pkgs; [
          bash-completion
          universal-ctags
          lsd
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
          nvi
          go
          gitmux
          starship
          asdf-vm
          raycast
          discord
          comic-mono
          karabiner-elements
        ];
    };

    programs = {
        starship = {
            enable = true;
        };

        bat = {
            enable = true;
        };

        fzf = {
            enable = true;
            enableBashIntegration = true;
        };

        git.enable = true;
    };
    home.stateVersion = "23.11";
}
