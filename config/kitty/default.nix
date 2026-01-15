let
  theme = import ../../shared/themes/terminal.nix;
in
{
  programs.kitty = {
    enable = true;
    font = {
      name = theme.font.family;
      size = theme.font.size;
    };
    settings = {
      # Window appearance
      background_opacity = toString theme.window.opacity;
      window_padding_width = theme.window.padding.x;
      window_margin_width = 0;
      single_window_margin_width = 0;
      window_border_width = "1pt";
      draw_minimal_borders = "yes";
      window_resize_step_cells = 2;
      window_resize_step_lines = 2;

      # Cursor
      cursor_shape = "block";
      cursor_blink_interval = "0.75";
      cursor_stop_blinking_after = "15.0";

      # Scrollback
      scrollback_lines = 10000;
      scrollback_pager_history_size = 0;
      wheel_scroll_multiplier = "3.0";

      # Mouse
      mouse_hide_wait = "3.0";
      url_style = "curly";
      open_url_modifiers = "kitty_mod";
      open_url_with = "default";
      copy_on_select = "yes";

      # Performance
      repaint_delay = 10;
      input_delay = 3;
      sync_to_monitor = "yes";

      # Bell
      enable_audio_bell = "no";
      visual_bell_duration = "0.0";

      # Tab bar
      tab_bar_edge = "bottom";
      tab_bar_margin_width = "0.0";
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
      tab_title_template = "{title}{' :{}:'.format(num_windows) if num_windows > 1 else ''}";

      # Color scheme - Tokyo Night
      foreground = theme.colors.primary.foreground;
      background = theme.colors.primary.background;
      selection_foreground = theme.colors.selection.foreground;
      selection_background = theme.colors.selection.background;

      # Cursor colors
      cursor = theme.colors.cursor.background;
      cursor_text_color = theme.colors.cursor.foreground;

      # URL underline color when hovering with mouse
      url_color = "#73daca";

      # Kitty window border colors
      active_border_color = "#7aa2f7";
      inactive_border_color = "#292e42";
      bell_border_color = "#ff9e64";

      # OS Window titlebar colors
      wayland_titlebar_color = "system";
      macos_titlebar_color = "system";

      # Tab bar colors
      active_tab_foreground = "#1d202f";
      active_tab_background = "#7aa2f7";
      inactive_tab_foreground = "#787c99";
      inactive_tab_background = "#1f2335";
      tab_bar_background = "#15161e";

      # Colors for marks (marked text in the terminal)
      mark1_foreground = "#1a1b26";
      mark1_background = "#73daca";
      mark2_foreground = "#1a1b26";
      mark2_background = "#f7768e";
      mark3_foreground = "#1a1b26";
      mark3_background = "#e0af68";

      # The 16 terminal colors

      # black
      color0 = theme.colors.normal.black;
      color8 = theme.colors.bright.black;

      # red
      color1 = theme.colors.normal.red;
      color9 = theme.colors.bright.red;

      # green
      color2 = theme.colors.normal.green;
      color10 = theme.colors.bright.green;

      # yellow
      color3 = theme.colors.normal.yellow;
      color11 = theme.colors.bright.yellow;

      # blue
      color4 = theme.colors.normal.blue;
      color12 = theme.colors.bright.blue;

      # magenta
      color5 = theme.colors.normal.magenta;
      color13 = theme.colors.bright.magenta;

      # cyan
      color6 = theme.colors.normal.cyan;
      color14 = theme.colors.bright.cyan;

      # white
      color7 = theme.colors.normal.white;
      color15 = theme.colors.bright.white;
    };
  };
}
