Zellij

Purpose
- Terminal workspace manager for tabs and panes, similar to tmux.

Start
- New session: zellij
- Named session: zellij -s <name>
- List sessions: zellij list-sessions
- Attach session: zellij attach <name>
- Delete session: zellij delete-session <name>

Basics
- Prefix is Ctrl g.
- Lock/unlock: Ctrl g.
- Quit: Ctrl q.

Panes
- Pane mode: Ctrl p.
- New pane: n.
- Split down: d.
- Split right: r.
- Close focused pane: x.
- Toggle fullscreen focused pane: f.

Tabs
- Tab mode: Ctrl t.
- New tab: n.
- Next tab: l or Right or Down.
- Previous tab: h or Left or Up.
- Close tab: x.

Notes
- Config lives at ~/.config/zellij/config.kdl via this repo.
