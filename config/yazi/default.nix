{ config, lib, pkgs, ... }:

{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      mgr = {
        # Layout and appearance
        layout = [ 1 4 3 ];
        sort_by = "alphabetical";
        sort_sensitive = false;
        sort_reverse = false;
        sort_dir_first = true;
        linemode = "none";
        show_hidden = false;
        show_symlink = true;
        scrolloff = 5;

        # Preview settings
        ratio = [ 1 3 4 ];
      };

      preview = {
        # Image preview
        image_filter = "triangle";
        image_quality = 75;

        # Text preview
        tab_size = 2;
        max_width = 600;
        max_height = 900;
        cache_dir = "";

        # Ueberzug settings for image preview
        ueberzug_scale = 1;
        ueberzug_offset = [ 0 0 0 0 ];
      };

      opener = {
        # Text files
        edit = [
          { run = "$EDITOR \"$@\""; desc = "Edit"; block = true; }
        ];

        # Images
        open = [
          { run = "open \"$@\""; desc = "Open"; }
        ];

        # Videos
        play = [
          { run = "mpv \"$@\""; desc = "Play"; }
          { run = "open \"$@\""; desc = "Open"; }
        ];

        # Archives
        extract = [
          { run = "unar \"$@\""; desc = "Extract here"; }
        ];

        # Reveal in Finder (macOS)
        reveal = [
          { run = "open -R \"$@\""; desc = "Reveal in Finder"; }
        ];
      };

      open = {
        # File associations
        rules = [
          { name = "*/"; use = [ "edit" "open" "reveal" ]; }
          { mime = "text/*"; use = [ "edit" "reveal" ]; }
          { mime = "image/*"; use = [ "open" "reveal" ]; }
          { mime = "video/*"; use = [ "play" "reveal" ]; }
          { mime = "audio/*"; use = [ "play" "reveal" ]; }
          { mime = "inode/x-empty"; use = [ "edit" "reveal" ]; }
          { mime = "application/json"; use = [ "edit" "reveal" ]; }
          { mime = "*/javascript"; use = [ "edit" "reveal" ]; }
          { mime = "application/zip"; use = [ "extract" "reveal" ]; }
          { mime = "application/gzip"; use = [ "extract" "reveal" ]; }
          { mime = "application/x-tar"; use = [ "extract" "reveal" ]; }
          { mime = "application/x-bzip2"; use = [ "extract" "reveal" ]; }
          { mime = "application/x-7z-compressed"; use = [ "extract" "reveal" ]; }
          { mime = "application/x-rar"; use = [ "extract" "reveal" ]; }
          { mime = "*"; use = [ "open" "reveal" ]; }
        ];
      };

      tasks = {
        micro_workers = 10;
        macro_workers = 25;
        bizarre_retry = 5;
        image_alloc = 536870912; # 512MB
        image_bound = [ 0 0 ];
        suppress_preload = false;
      };

      plugin = {
        prepend_preloaders = [
          { mime = "image/{avif,heix}"; run = "magick"; }
          { mime = "image/svg+xml"; run = "magick"; }
          { mime = "image/webp"; run = "magick"; }
          { name = "*.md"; run = "glow"; }
        ];

        append_previewers = [
          { name = "*.md"; run = "glow"; }
          { mime = "text/csv"; run = "miller"; }
          { mime = "application/json"; run = "jq"; }
        ];
      };

      input = {
        # Cursor
        cursor_blink = true;

        # Find
        find_origin = "top-left";
        find_offset = [ 0 2 50 3 ];
      };

      select = {
        open_multi = true;
      };

      which = {
        sort_by = "none";
        sort_sensitive = false;
        sort_reverse = false;
      };

      log = {
        enabled = false;
      };
    };

    # Key bindings
    keymap = {
      mgr.prepend_keymap = [
        # Navigation
        { on = [ "<C-n>" ]; run = "arrow 1"; desc = "Move cursor down"; }
        { on = [ "<C-p>" ]; run = "arrow -1"; desc = "Move cursor up"; }
        { on = [ "<C-d>" ]; run = "arrow 5"; desc = "Move cursor down 5 lines"; }
        { on = [ "<C-u>" ]; run = "arrow -5"; desc = "Move cursor up 5 lines"; }

        # File operations
        { on = [ "y" "y" ]; run = "yank"; desc = "Copy selected files"; }
        { on = [ "y" "n" ]; run = "yank --cut"; desc = "Cut selected files"; }
        { on = [ "p" ]; run = "paste"; desc = "Paste files"; }
        { on = [ "P" ]; run = "paste --force"; desc = "Paste files (overwrite)"; }
        { on = [ "d" "d" ]; run = "remove"; desc = "Move to trash"; }
        { on = [ "D" ]; run = "remove --permanently"; desc = "Delete permanently"; }

        # Create
        { on = [ "a" ]; run = "create"; desc = "Create file/directory"; }
        { on = [ "r" ]; run = "rename"; desc = "Rename"; }

        # Selection
        { on = [ "<Space>" ]; run = "select --state=none"; desc = "Toggle selection"; }
        { on = [ "v" ]; run = "visual_mode"; desc = "Enter visual mode"; }
        { on = [ "V" ]; run = "visual_mode --unset"; desc = "Enter visual mode (unset)"; }
        { on = [ "<C-a>" ]; run = "select_all --state=true"; desc = "Select all"; }
        { on = [ "<C-r>" ]; run = "select_all --state=none"; desc = "Inverse selection"; }

        # Search
        { on = [ "/" ]; run = "find --smart"; desc = "Find"; }
        { on = [ "?" ]; run = "find --previous --smart"; desc = "Find previous"; }
        { on = [ "n" ]; run = "find_arrow"; desc = "Go to next found"; }
        { on = [ "N" ]; run = "find_arrow --previous"; desc = "Go to previous found"; }

        # Sorting
        { on = [ "," "m" ]; run = "sort modified --reverse=no"; desc = "Sort by modified time"; }
        { on = [ "," "M" ]; run = "sort modified --reverse"; desc = "Sort by modified time (reverse)"; }
        { on = [ "," "c" ]; run = "sort created --reverse=no"; desc = "Sort by created time"; }
        { on = [ "," "C" ]; run = "sort created --reverse"; desc = "Sort by created time (reverse)"; }
        { on = [ "," "e" ]; run = "sort extension --reverse=no"; desc = "Sort by extension"; }
        { on = [ "," "E" ]; run = "sort extension --reverse"; desc = "Sort by extension (reverse)"; }
        { on = [ "," "s" ]; run = "sort size --reverse=no"; desc = "Sort by size"; }
        { on = [ "," "S" ]; run = "sort size --reverse"; desc = "Sort by size (reverse)"; }
        { on = [ "," "n" ]; run = "sort alphabetical --reverse=no"; desc = "Sort alphabetically"; }
        { on = [ "," "N" ]; run = "sort alphabetical --reverse"; desc = "Sort alphabetically (reverse)"; }

        # Tabs
        { on = [ "t" ]; run = "tab_create --current"; desc = "Create new tab"; }
        { on = [ "1" ]; run = "tab_switch 0"; desc = "Switch to tab 1"; }
        { on = [ "2" ]; run = "tab_switch 1"; desc = "Switch to tab 2"; }
        { on = [ "3" ]; run = "tab_switch 2"; desc = "Switch to tab 3"; }
        { on = [ "4" ]; run = "tab_switch 3"; desc = "Switch to tab 4"; }
        { on = [ "5" ]; run = "tab_switch 4"; desc = "Switch to tab 5"; }
        { on = [ "6" ]; run = "tab_switch 5"; desc = "Switch to tab 6"; }
        { on = [ "7" ]; run = "tab_switch 6"; desc = "Switch to tab 7"; }
        { on = [ "8" ]; run = "tab_switch 7"; desc = "Switch to tab 8"; }
        { on = [ "9" ]; run = "tab_switch 8"; desc = "Switch to tab 9"; }
        { on = [ "[" ]; run = "tab_switch -1 --relative"; desc = "Switch to previous tab"; }
        { on = [ "]" ]; run = "tab_switch 1 --relative"; desc = "Switch to next tab"; }
        { on = [ "{" ]; run = "tab_swap -1"; desc = "Swap current tab with previous"; }
        { on = [ "}" ]; run = "tab_swap 1"; desc = "Swap current tab with next"; }

        # Operations
        { on = [ "o" ]; run = "open"; desc = "Open"; }
        { on = [ "O" ]; run = "open --interactive"; desc = "Open interactively"; }
        { on = [ "<Enter>" ]; run = "open"; desc = "Open"; }
        { on = [ "<C-Enter>" ]; run = "open --interactive"; desc = "Open interactively"; }

        # Copy paths
        { on = [ "c" "c" ]; run = "copy path"; desc = "Copy absolute path"; }
        { on = [ "c" "d" ]; run = "copy dirname"; desc = "Copy directory path"; }
        { on = [ "c" "f" ]; run = "copy filename"; desc = "Copy filename"; }
        { on = [ "c" "n" ]; run = "copy name_without_ext"; desc = "Copy name without extension"; }

        # Filter
        { on = [ "f" ]; run = "filter --smart"; desc = "Filter"; }

        # Hidden files
        { on = [ "." ]; run = "hidden toggle"; desc = "Toggle hidden files"; }

        # Shell
        { on = [ "!" ]; run = "shell"; desc = "Run shell command"; }
        { on = [ "<C-s>" ]; run = "shell --interactive"; desc = "Run shell command interactively"; }

        # Help
        { on = [ "~" ]; run = "help"; desc = "Open help"; }
      ];
    };

    # Theme configuration with Tokyo Night colors
    theme = {
      mgr = {
        cwd = { fg = "#7aa2f7"; };
        hovered = { fg = "#c0caf5"; bg = "#3b4261"; };
        preview_hovered = { underline = true; };
        find_keyword = { fg = "#f7768e"; italic = true; };
        find_position = { fg = "#bb9af7"; bg = "reset"; italic = true; };
        marker_selected = { fg = "#9ece6a"; bg = "#9ece6a"; };
        marker_copied = { fg = "#e0af68"; bg = "#e0af68"; };
        marker_cut = { fg = "#f7768e"; bg = "#f7768e"; };
        tab_active = { fg = "#1a1b26"; bg = "#7aa2f7"; };
        tab_inactive = { fg = "#a9b1d6"; bg = "#24283b"; };
        tab_width = 1;
        border_symbol = "│";
        border_style = { fg = "#565f89"; };
      };

      status = {
        separator_open = "";
        separator_close = "";
        separator_style = { fg = "#3b4261"; bg = "#3b4261"; };
        mode_normal = { fg = "#1a1b26"; bg = "#7aa2f7"; bold = true; };
        mode_select = { fg = "#1a1b26"; bg = "#9ece6a"; bold = true; };
        mode_unset = { fg = "#1a1b26"; bg = "#f7768e"; bold = true; };
        progress_label = { fg = "#c0caf5"; bold = true; };
        progress_normal = { fg = "#7aa2f7"; bg = "#24283b"; };
        progress_error = { fg = "#f7768e"; bg = "#24283b"; };
        permissions_t = { fg = "#9ece6a"; };
        permissions_r = { fg = "#e0af68"; };
        permissions_w = { fg = "#f7768e"; };
        permissions_x = { fg = "#7dcfff"; };
        permissions_s = { fg = "#565f89"; };
      };

      input = {
        border = { fg = "#7aa2f7"; };
        title = { fg = "#c0caf5"; };
        value = { fg = "#c0caf5"; };
        selected = { reversed = true; };
      };

      select = {
        border = { fg = "#7aa2f7"; };
        active = { fg = "#bb9af7"; };
        inactive = { fg = "#a9b1d6"; };
      };

      tasks = {
        border = { fg = "#7aa2f7"; };
        title = { fg = "#c0caf5"; };
        hovered = { underline = true; };
      };

      which = {
        mask = { bg = "#1a1b26"; };
        cand = { fg = "#7dcfff"; };
        rest = { fg = "#a9b1d6"; };
        desc = { fg = "#bb9af7"; };
        separator = "  ";
        separator_style = { fg = "#565f89"; };
      };

      help = {
        on = { fg = "#bb9af7"; };
        exec = { fg = "#7dcfff"; };
        desc = { fg = "#a9b1d6"; };
        hovered = { bg = "#3b4261"; bold = true; };
        footer = { fg = "#1a1b26"; bg = "#a9b1d6"; };
      };

      filetype = {
        rules = [
          # Images
          { mime = "image/*"; fg = "#7dcfff"; }
          # Videos
          { mime = "video/*"; fg = "#e0af68"; }
          { mime = "audio/*"; fg = "#e0af68"; }
          # Archives
          { mime = "application/zip"; fg = "#f7768e"; }
          { mime = "application/gzip"; fg = "#f7768e"; }
          { mime = "application/x-tar"; fg = "#f7768e"; }
          { mime = "application/x-bzip2"; fg = "#f7768e"; }
          { mime = "application/x-7z-compressed"; fg = "#f7768e"; }
          { mime = "application/x-rar"; fg = "#f7768e"; }
          # Documents
          { mime = "application/pdf"; fg = "#f7768e"; }
          { name = "*.md"; fg = "#c0caf5"; }
          { name = "*.txt"; fg = "#c0caf5"; }
          # Code
          { name = "*.js"; fg = "#e0af68"; }
          { name = "*.ts"; fg = "#7aa2f7"; }
          { name = "*.jsx"; fg = "#7dcfff"; }
          { name = "*.tsx"; fg = "#7dcfff"; }
          { name = "*.py"; fg = "#e0af68"; }
          { name = "*.rs"; fg = "#f7768e"; }
          { name = "*.go"; fg = "#7dcfff"; }
          { name = "*.php"; fg = "#bb9af7"; }
          { name = "*.rb"; fg = "#f7768e"; }
          { name = "*.java"; fg = "#f7768e"; }
          { name = "*.c"; fg = "#7aa2f7"; }
          { name = "*.cpp"; fg = "#7aa2f7"; }
          { name = "*.h"; fg = "#7aa2f7"; }
          { name = "*.hpp"; fg = "#7aa2f7"; }
          { name = "*.css"; fg = "#7aa2f7"; }
          { name = "*.scss"; fg = "#bb9af7"; }
          { name = "*.html"; fg = "#f7768e"; }
          { name = "*.xml"; fg = "#f7768e"; }
          { name = "*.json"; fg = "#e0af68"; }
          { name = "*.yaml"; fg = "#e0af68"; }
          { name = "*.yml"; fg = "#e0af68"; }
          { name = "*.toml"; fg = "#e0af68"; }
          { name = "*.ini"; fg = "#e0af68"; }
          { name = "*.conf"; fg = "#e0af68"; }
          { name = "*.nix"; fg = "#7aa2f7"; }
          # Shell
          { name = "*.sh"; fg = "#9ece6a"; }
          { name = "*.bash"; fg = "#9ece6a"; }
          { name = "*.zsh"; fg = "#9ece6a"; }
          { name = "*.fish"; fg = "#9ece6a"; }
          # Git
          { name = ".gitignore"; fg = "#565f89"; }
          { name = ".gitmodules"; fg = "#565f89"; }
          { name = ".gitattributes"; fg = "#565f89"; }
          # Directories
          { name = "*/"; fg = "#7aa2f7"; }
          # Default
          { name = "*"; fg = "#c0caf5"; }
        ];
      };
    };
  };
}
