Tmux Usage

Key setup
- Prefix is C-a
- Reload config: Prefix + r
- Help panel: Prefix + ?

Pane management
- Split vertical: Prefix + |
- Split horizontal: Prefix + -
- Move panes: Prefix + h/j/k/l
- Resize panes: Prefix + H/J/K/L

Windows
- New window: Prefix + c
- Switch windows: Alt + 1..9

Copy mode
- Enter copy mode: Prefix + v
- Start selection: v
- Copy selection: y

Notes
- Session restore is enabled via tmux-resurrect/continuum.
- Copy uses pbcopy; on Linux switch to wl-copy or xclip if needed.

Full docs: docs/tools/tmux.md
