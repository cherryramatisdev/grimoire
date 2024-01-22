{ pkgs, ... }: {
  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellOptions = [
      "checkwinsize"
      "expand_aliases"
      "globstar"
      "dotglob"
      "extglob"
    ];
    profileExtra = ''
      . "$HOME/.cargo/env"

      test -r /Users/cherry/.opam/opam-init/init.sh && . /Users/cherry/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true
    '';
    initExtra = ''
      # ------------------------------ util functions ------------------------------
      _have() { type "$1" &>/dev/null; }

      # ------------------------------ my settings ------------------------------
      export PS1="🍒 "
      export SNIPPETS="$HOME/Repos/stowed/snippets"
      export REVIEWERS="$(cat ~/reviewers | tr '\n' , | sed 's/,$//')"
      export KEG_CURRENT=~/Repos/zet
      if command -v pkg-config; then
        export CGO_CFLAGS="$(pkg-config --cflags openssl)"
        export CGO_LDFLAGS="$(pkg-config --libs openssl)"
      fi
      # export LIBRARY_PATH=$LIBRARY_PATH:/opt/homebrew/opt/openssl@3/lib/
      export NODE_OPTIONS="--max-old-space-size=4096"

      export XDG_CONFIG_HOME="$HOME/.config"

      # This make the docker run correctly for arm
      export DOCKER_DEFAULT_PLATFORM=linux/amd64

      # ------------------------------ setup languages/tools ------------------------------

      # fzf
      export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
      export FZF_CTRL_T_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
      export FZF_DEFAULT_OPTS='--bind ctrl-u:preview-up,ctrl-d:preview-down'

      # golang
      export GOBIN="$HOME/go/bin"
      export GOCACHE=$HOME/.cache/go-build
      export PATH="$GOBIN:$PATH"

      # dev.to
       if [[ -f ~/devto ]]; then
         export DEVTO_API_KEY="$(cat ~/devto | tr '\n' , | sed 's/,$//')"
       fi

      # ------------------------------ config PATH ------------------------------
      export PATH="$HOME/bin:$PATH"
      export PATH="$HOME/Scripts:$PATH"
      export PATH="$HOME/.local/bin:$PATH"
      export PATH="$HOME/.npm-global/bin:$PATH"
      export PATH="/opt/homebrew/bin:$PATH"
      #export PATH="/opt/homebrew/opt/ruby@3.1/bin:$PATH"
      #export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
      #export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
      export PATH="$PATH:$HOME/.rvm/bin"
      export PATH="$HOME/Library/pnpm:$PATH"
      export PATH=$PATH:$HOME/.local/share/elixir-ls/
      export PATH=$PATH:$HOME/.ghcup/bin
      export PATH="$PATH:$HOME/.asdf/shims"
      export PATH="$PATH:$HOME/.cabal/bin"

      # Configure own installer scripts
      [ -f "$HOME/.asdf/asdf.sh" ] && . "$HOME/.asdf/asdf.sh"

      # ------------------------------ cdpath ------------------------------

      export REPOS="$HOME/Repos"
      export WORK="$HOME/Work"
      export SCRIPTS="$HOME/Scripts"
      export CONFIG="$HOME/.config"
      export CDPATH=".:$REPOS:$WORK:$WORK/360hub:$HOME:$CONFIG"

      # ------------------------ bash completion ------------------------
      [[ -f "/etc/profiles/per-user/cherry/share/bash-completion/completions/pixie" ]] && . "/etc/profiles/per-user/cherry/share/bash-completion/completions/pixie"

      _have gh && . <(gh completion -s bash)

      complete -C vic vic
      # complete -C pixie pixie
      complete -C p p # alias for pixie
      complete -C pkg pkg

      eval "$(starship init bash)"

      # pnpm
      export PNPM_HOME="/Users/cherry/Library/pnpm"
      case ":$PATH:" in
        *":$PNPM_HOME:"*) ;;
        *) export PATH="$PNPM_HOME:$PATH" ;;
      esac
      # pnpm end
      [ -f "/Users/cherry/.ghcup/env" ] && source "/Users/cherry/.ghcup/env" # ghcup-env

      # bun
      export BUN_INSTALL="$HOME/.bun"
      export PATH=$BUN_INSTALL/bin:$PATH

      set -o vi
    '';
    shellAliases = {
      jira = "~/Scripts/jirarust";
      chmox = "chmod +x";
      l = "eza";
      ls = "eza";
      ll = "eza -ll";
      la = "eza -la";
      lg = "lazygit";
      gst = "git st";
      ga = "git a";
      gd = "git diff";
      gci = "git ci";
      gco = "git checkout";
      gs = "git show";
      gc = "~/Scripts/gc";
      gp = "~/Scripts/gp";
      gup = "~/Scripts/gup";
      o = "git oneline";
      oo = "git oneline -10";
      gr = "git rebase";
      gre = "git restore";
      gres = "git restore --staged";
      cat = "bat";
      t = "tmux";
      e = "exit";
      c = "clear";
      # clear = ''
      #   printf "\e[H\e[2J"
      # '';
      # c = ''
      #   printf "\e[H\e[2J"
      # '';
      b = "bundle";
      be = "bundle exec";
      ba = "bundle add";
      validate = "yarn test && yarn build && yarn lint";
      tmp = "cd \"$(mktemp -d /tmp/XXXXXX)\"";
      depupdate = "yarn upgrade-interactive --latest";
      fishies = "asciiquarium";
      lowercase = "tr '[:upper:]' '[:lower:]'";
      postgresup = "docker run --rm --name postgres -p 5432:5432 -e POSTGRES_PASSWORD=postgres -e TZ=America/Sao_Paulo -d postgres";
      dsp = "docker system prune -a";
      db = "docker build";
      dr = "docker run";
      dcu = "docker-compose up";
      dcd = "docker-compose down";
      ca = "cargo";
      vi = "nvim";
      vim = "nvim";
    };
  };
}
