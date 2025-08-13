{ pkgs, ... }:
# Enhanced tmux configuration with modern styling
{
  programs.tmux = {
    enable = true;
    clock24 = true;
    keyMode = "vi";
    mouse = true;
    baseIndex = 1;
    escapeTime = 0;
    historyLimit = 50000;

    # Modern key bindings
    prefix = "C-a";

    # Terminal settings
    terminal = "screen-256color";

    extraConfig = ''
      # ===== TOKYO NIGHT THEME =====
      # Status bar colors
      set -g status-style "bg=#1a1b26,fg=#c0caf5"
      set -g status-left-style "bg=#7aa2f7,fg=#1a1b26,bold"
      set -g status-right-style "bg=#414868,fg=#c0caf5"
      
      # Window status colors
      set -g window-status-style "bg=#1a1b26,fg=#565f89"
      set -g window-status-current-style "bg=#7aa2f7,fg=#1a1b26,bold"
      set -g window-status-activity-style "bg=#f7768e,fg=#1a1b26"
      
      # Pane border colors
      set -g pane-border-style "fg=#414868"
      set -g pane-active-border-style "fg=#7aa2f7"
      
      # Message colors
      set -g message-style "bg=#7aa2f7,fg=#1a1b26,bold"
      set -g message-command-style "bg=#414868,fg=#c0caf5"
      
      # ===== STATUS BAR CONFIGURATION =====
      set -g status-position bottom
      set -g status-justify left
      set -g status-interval 2
      set -g status-left-length 50
      set -g status-right-length 100
      
      # Left status: session name with icon
      set -g status-left " 󰊠 #S "
      
      # Right status: system info with icons
      set -g status-right "#[bg=#414868,fg=#c0caf5] 󰃰 %d/%m #[bg=#7aa2f7,fg=#1a1b26,bold] 󰥔 %H:%M "
      
      # Window status format
      set -g window-status-format " #I:#W "
      set -g window-status-current-format " #I:#W "
      
      # ===== KEY BINDINGS =====
      # Unbind default prefix and set new one
      unbind C-b
      bind C-a send-prefix
      
      # Reload config
      bind r source-file ~/.config/tmux/tmux.conf \; display-message "Config reloaded!"
      
      # Split panes with intuitive keys
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
      unbind '"'
      unbind %
      
      # Switch panes with vim-like keys
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R
      
      # Resize panes
      bind -r H resize-pane -L 5
      bind -r J resize-pane -D 5
      bind -r K resize-pane -U 5
      bind -r L resize-pane -R 5
      
      # Create new window in current path
      bind c new-window -c "#{pane_current_path}"
      
      # Switch windows with Alt+number
      bind -n M-1 select-window -t 1
      bind -n M-2 select-window -t 2
      bind -n M-3 select-window -t 3
      bind -n M-4 select-window -t 4
      bind -n M-5 select-window -t 5
      bind -n M-6 select-window -t 6
      bind -n M-7 select-window -t 7
      bind -n M-8 select-window -t 8
      bind -n M-9 select-window -t 9
      
      # ===== HELP PANEL =====
      # Toggle help panel with Prefix + ?
      bind ? display-popup -E -w 80 -h 25 -x C -y C '
        echo "\033[1;36m╭─────────────────────────────────────────────────────────────────────────────╮\033[0m"
        echo "\033[1;36m│\033[1;37m                            TMUX HELP PANEL                                \033[1;36m│\033[0m"
        echo "\033[1;36m├─────────────────────────────────────────────────────────────────────────────┤\033[0m"
        echo "\033[1;36m│\033[0m \033[1;33mSESSION MANAGEMENT\033[0m                                                     \033[1;36m│\033[0m"
        echo "\033[1;36m│\033[0m   \033[1;32mPrefix + d\033[0m     Detach from session                                \033[1;36m│\033[0m"
        echo "\033[1;36m│\033[0m   \033[1;32mPrefix + s\033[0m     List sessions                                      \033[1;36m│\033[0m"
        echo "\033[1;36m│\033[0m   \033[1;32mPrefix + $\033[0m     Rename session                                     \033[1;36m│\033[0m"
        echo "\033[1;36m│\033[0m                                                                       \033[1;36m│\033[0m"
        echo "\033[1;36m│\033[0m \033[1;33mWINDOW MANAGEMENT\033[0m                                                      \033[1;36m│\033[0m"
        echo "\033[1;36m│\033[0m   \033[1;32mPrefix + c\033[0m     Create new window                                  \033[1;36m│\033[0m"
        echo "\033[1;36m│\033[0m   \033[1;32mPrefix + ,\033[0m     Rename window                                      \033[1;36m│\033[0m"
        echo "\033[1;36m│\033[0m   \033[1;32mPrefix + &\033[0m     Kill window                                        \033[1;36m│\033[0m"
        echo "\033[1;36m│\033[0m   \033[1;32mAlt + 1-9\033[0m      Switch to window 1-9                               \033[1;36m│\033[0m"
        echo "\033[1;36m│\033[0m                                                                       \033[1;36m│\033[0m"
        echo "\033[1;36m│\033[0m \033[1;33mPANE MANAGEMENT\033[0m                                                        \033[1;36m│\033[0m"
        echo "\033[1;36m│\033[0m   \033[1;32mPrefix + |\033[0m     Split vertically                                   \033[1;36m│\033[0m"
        echo "\033[1;36m│\033[0m   \033[1;32mPrefix + -\033[0m     Split horizontally                                 \033[1;36m│\033[0m"
        echo "\033[1;36m│\033[0m   \033[1;32mPrefix + h/j/k/l\033[0m Navigate panes (vim-style)                       \033[1;36m│\033[0m"
        echo "\033[1;36m│\033[0m   \033[1;32mPrefix + H/J/K/L\033[0m Resize panes                                     \033[1;36m│\033[0m"
        echo "\033[1;36m│\033[0m   \033[1;32mPrefix + x\033[0m     Kill pane                                          \033[1;36m│\033[0m"
        echo "\033[1;36m│\033[0m                                                                       \033[1;36m│\033[0m"
        echo "\033[1;36m│\033[0m \033[1;33mCOPY MODE\033[0m                                                              \033[1;36m│\033[0m"
        echo "\033[1;36m│\033[0m   \033[1;32mPrefix + v\033[0m     Enter copy mode                                    \033[1;36m│\033[0m"
        echo "\033[1;36m│\033[0m   \033[1;32mv\033[0m              Start selection (in copy mode)                    \033[1;36m│\033[0m"
        echo "\033[1;36m│\033[0m   \033[1;32my\033[0m              Copy selection (in copy mode)                     \033[1;36m│\033[0m"
        echo "\033[1;36m│\033[0m                                                                       \033[1;36m│\033[0m"
        echo "\033[1;36m│\033[0m \033[1;33mOTHER\033[0m                                                                  \033[1;36m│\033[0m"
        echo "\033[1;36m│\033[0m   \033[1;32mPrefix + r\033[0m     Reload config                                      \033[1;36m│\033[0m"
        echo "\033[1;36m│\033[0m   \033[1;32mPrefix + ?\033[0m     Show this help                                     \033[1;36m│\033[0m"
        echo "\033[1;36m╰─────────────────────────────────────────────────────────────────────────────╯\033[0m"
        echo ""
        echo "\033[1;35mPress any key to close this help panel...\033[0m"
        read -n 1
      '
      
      # ===== COPY MODE SETTINGS =====
      # Enter copy mode with v
      bind v copy-mode
      
      # Copy mode key bindings (vi-style)
      bind -T copy-mode-vi v send-keys -X begin-selection
      bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "pbcopy"
      bind -T copy-mode-vi r send-keys -X rectangle-toggle
      
      # ===== GENERAL SETTINGS =====
      # Enable focus events
      set -g focus-events on
      
      # Enable true color support
      set -ga terminal-overrides ",*256col*:Tc"
      
      # Disable automatic window renaming
      set -g allow-rename off
      
      # Enable activity monitoring
      setw -g monitor-activity on
      set -g visual-activity off
      
      # Increase scrollback buffer
      set -g history-limit 50000
      
      # Start window and pane numbering at 1
      set -g base-index 1
      setw -g pane-base-index 1
      
      # Renumber windows when one is closed
      set -g renumber-windows on
      
      # Faster command sequences
      set -s escape-time 0
      
      # Aggressive resize
      setw -g aggressive-resize on
    '';
  };
}
