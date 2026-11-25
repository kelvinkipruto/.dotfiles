Daily Dev Loop

Goal
- Fast navigation, quick file edits, and clean git flow.

Start a session
- tmux new -s work
- Split: Prefix + | and Prefix + -
- Jump dirs: z <project>

Explore files
- yazi opens in the project root
- Filter with f, search with /
- Open files with Enter

Search and edit
- rg "query" .
- Open in editor: nvim <file>

Git loop
- lazygit (or use git aliases: st, br, co, cm)
- Review diffs with delta

Close
- Detach: Prefix + d
- Session restores on next tmux launch
