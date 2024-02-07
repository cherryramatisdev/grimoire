{ pkgs, ... }: {
  programs.git = {
    enable = true;
    userName = "Cherry Ramatis";
    userEmail = "cherry.ramatis@icloud.com";
    aliases = {
      amend = "commit --amend -v";
      a = "add";
      br = "branch";
      ci = "commit -v";
      co = "checkout";
      full = "show --format=fuller";
      one = "!git --paginate log --pretty=format:'%C(auto)%h%Creset %s%C(auto)%d%Creset %C(magenta bold)(%cr)%Creset %C(cyan)<%aN>%Creset'";
      oneline = "!git --paginate log --pretty=format:'%C(auto)%h%Creset %s%C(auto)%d%Creset %C(magenta bold)(%cr)%Creset %C(cyan)<%aN>%Creset'";
      p = "add -p";
      browse = "!browse_commit";
      patch = "add -p";
      recover = ''
        !cat "$(git rev-parse --git-dir 2> /dev/null)/COMMIT_EDITMSG"
      '';
      reword = "commit --amend --only -v --";
      sl = ''
        !git --paginate log --graph --pretty=format:'%C(auto)%h%Creset%C(auto)%d%Creset %s %C(magenta bold)(%cr)%Creset %C(cyan)<%aN>%Creset' --all --simplify-by-decoration
      '';
      st = "status";
      staged = "diff --cached --ignore-submodules=dirty";
    };
    extraConfig = {
      color = {
        ui = true;
      };
      github = {
        user = "cherryramatisdev";
      };
      pull = {
        rebase = false;
      };
      core = {
        pager = "delta --features \"$(defaults read -globalDomain AppleInterfaceStyle > /dev/null 2>&1 && echo dark-mode || echo light-mode)\"";
      };
      interactive = {
        diffFilter = "delta --color-only --features \"$(defaults read -globalDomain AppleInterfaceStyle &> /dev/null && echo dark-mode || echo light-mode)\"";
      };
      delta = {
        side-by-side = true;
        navigate = true;
        light-mode = {
          light = true;
          syntax-theme = "GitHub";
        };
        dark-mode = {
          light = false;
          syntax-theme = "Visual Studio Dark+";

        };
      };
      merge = {
        conflitstyle = "diff3";
        tool = "nvimdiff";
      };
      diff = {
        colorMoved = "default";
      };
      push = {
        default = "current";
      };
      mergetool = {
        prompt = false;
        keepBackup = false;
      };
      init = {
        defaultBranch = "main";
      };
    };
  };
}
