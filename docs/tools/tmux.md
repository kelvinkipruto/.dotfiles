Tmux

Purpose
- Terminal multiplexer for long-running sessions and split panes.

Prefix
- Prefix is C-a.
- Help panel: Prefix + ?
- Reload config: Prefix + r

Sessions
- Detach: Prefix + d
- List sessions: Prefix + s
- Rename session: Prefix + $
- Attach: tmux attach -t <name>

Windows
- New window: Prefix + c
- Rename window: Prefix + ,
- Kill window: Prefix + &
- Switch windows: Alt + 1..9

Panes
- Split vertical: Prefix + |
- Split horizontal: Prefix + -
- Move focus: Prefix + h/j/k/l
- Resize: Prefix + H/J/K/L
- Kill pane: Prefix + x

Copy mode
- Enter copy mode: Prefix + v
- Start selection: v
- Copy selection: y

Plugins
- tmux-resurrect saves sessions, tmux-continuum restores on start.
- Restore runs automatically; manual restore: Prefix + Ctrl-r (default plugin binding).

Notes
- Clipboard uses pbcopy on macOS. Replace with wl-copy or xclip on Linux if needed.
