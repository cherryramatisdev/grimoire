{ pkgs, ... }: {
  programs.tmux = {
    enable = true;
    keyMode = "vi";
    extraConfig = ''
      set -g terminal-overrides ',xterm-256color:Tc'
      # set -g default-terminal "tmux-256color"
      set -g default-terminal "xterm-256color"
      set -as terminal-overrides ',xterm*:sitm=\E[3m'

      # start window indexing at one instead of zero
      set -g base-index 1 
      set -g pane-base-index 1
      set -g renumber-windows on
      setw -g mode-keys vi
      # fix accidently typing accent characters, etc.
      # by forcing the terminal to not wait around # (every single tmux file should have this)
      set -sg escape-time 0

      # This config allow vim to detect edit on another panes and make options like
      # "autoread" work properly
      set -g focus-events on

      set -g history-limit 1000000
      # set -g mouse on

      # ------------------- Tmux Appearance --------------------
      set -g status-style "fg=colour2"
      set -g status-bg default
      set -g status-position top
      set -g status-interval 1
      set -g automatic-rename on
      set -g automatic-rename-format '#{b:pane_current_path}'
      set -g status-left ""
      set -g status-right-length 100
      set -g status-right '[#(gh_current_active_account)] #(date +"%d/%m/%Y %H:%m") #(gitmux "#{pane_current_path}")'

      set -g message-style "fg=red"

      if-shell "test -f ~/Repos/stowed/tmux-copycat/copycat.tmux" "run-shell ~/Repos/stowed/tmux-copycat/copycat.tmux"

      # If a pane is zoomed, set the status-bg to a darker blue
      set-hook -g after-resize-pane \
      'if "[ #{window_zoomed_flag} -eq 1 ]" \
          "run \"tmux set -g status-bg colour17\"" \
          "run \"tmux set -g status-bg default\""
      '

      # C-b is not acceptable as prefix -- Vim uses it
      unbind C-b
      set -g prefix C-Space
      bind C-Space last-window

      bind -T copy-mode-vi Enter send-keys -X copy-pipe-and-cancel "pbcopy"

      # Easy bindings for split
      bind '\' split-window -h -c "#{pane_current_path}"
      bind '-' split-window -v -c "#{pane_current_path}"
      unbind c
      bind c new-window -c "#{pane_current_path}"
      bind-key C-d kill-pane

      is_neovim="ps -o state= -o comm= -t '#{pane_tty}' \
                 | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(nvim|x?nvimx?)(diff)?$'"
      # VIM, NEOVIM, etc...
      is_any_vim="ps -o state= -o comm= -t '#{pane_tty}' \
              | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|l?n?vim?x?|fzf)(diff)?$'"
      # bind-key C-h  if-shell  "$is_neovim"  "send-keys C-w h"  "select-pane -L"
      # bind-key C-j   if-shell  "$is_neovim"  "send-keys C-w j"   "select-pane -D"
      # bind-key C-k  if-shell  "$is_neovim"  "send-keys C-w k"  "select-pane -U"
      # bind-key C-l   if-shell  "$is_neovim"  "send-keys C-w l"   "select-pane -R"
      # bind-key h  if-shell  "$is_neovim"  "send-keys C-w h"  "select-pane -L"
      # bind-key j   if-shell  "$is_neovim"  "send-keys C-w j"   "select-pane -D"
      # bind-key k  if-shell  "$is_neovim"  "send-keys C-w k"  "select-pane -U"
      # bind-key l   if-shell  "$is_neovim"  "send-keys C-w l"   "select-pane -R"

      bind-key C-h select-pane -L
      bind-key C-j  select-pane -D
      bind-key C-k select-pane -U
      bind-key C-l  select-pane -R
      bind-key h select-pane -L
      bind-key j  select-pane -D
      bind-key k select-pane -U
      bind-key l  select-pane -R

      bind -r H resize-pane -L 5
      bind -r J resize-pane -D 5
      bind -r K resize-pane -U 5
      bind -r L resize-pane -R 6

      bind r source ~/.tmux.conf \; display "Reloaded"

      # Search back to last prompt (mnemonic: "[b]ack"); searches for non-breaking
      # space in prompt.
      bind-key b copy-mode\; send-keys -X start-of-line\; send-keys -X search-backward "🍒"

      bind-key Enter run-shell "~/Scripts/runproject #{pane_current_path}"

      bind-key -T copy-mode-vi a send-keys -X copy-pipe-and-cancel "pbcopy"\; send-keys "git add $(pbpaste)" Enter "c;gst" Enter
      bind-key -T copy-mode-vi p send-keys -X copy-pipe-and-cancel "pbcopy"\; send-keys "git add -p $(pbpaste)" Enter

      bind-key -T copy-mode-vi C-f send-keys -X copy-pipe "tmux_open_selected_on_vim"
      bind-key -T copy-mode-vi o send-keys -X copy-pipe-and-cancel "~/Scripts/tmux_open"
      bind-key C-u copy-mode \; send -X search-backward "(https?://|git@|git://|ssh://|ftp://|file:///)[[:alnum:]?=%/_.:,;~@!#$&()*+-]*"

      # bind-key g if-shell "$is_neovim" "send-keys :startinsert | term Space lazygit Enter" "display-popup -E -d '#{pane_current_path}' -w 90% -h 90% "lazygit""
      bind-key g display-popup -E -d '#{pane_current_path}' -w 90% -h 90% "lazygit"
      bind-key t display-popup -E -d '#{pane_current_path}' -w 90% -h 90% "bash"
      bind-key e if-shell "$is_any_vim" "run-shell ~/Scripts/tmux_fff_vim" "display-popup -E -d '#{pane_current_path}' -w 90% -h 90% "fff""
    '';
  };
}
