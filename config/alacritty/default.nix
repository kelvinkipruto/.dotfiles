let
  theme = import ../../shared/themes/terminal.nix;
in
{
  programs.alacritty = {
    enable = true;
    settings = {
      # Window configuration
      window = {
        opacity = theme.window.opacity;
        padding = theme.window.padding;
        decorations = "full";
        startup_mode = "Windowed";
      };

      # Font configuration
      font = {
        normal = {
          family = theme.font.family;
          style = "Regular";
        };
        bold = {
          family = theme.font.family;
          style = "Bold";
        };
        italic = {
          family = theme.font.family;
          style = "Italic";
        };
        bold_italic = {
          family = theme.font.family;
          style = "Bold Italic";
        };
        size = theme.font.size;
      };

      # Color scheme - Tokyo Night theme
      colors = {
        primary = theme.colors.primary;
        selection = theme.colors.selection;
        normal = theme.colors.normal;
        bright = theme.colors.bright;
        indexed_colors = theme.colors.indexed;
      };

      # Cursor configuration
      cursor = {
        style = {
          shape = "Block";
          blinking = "On";
        };
        blink_interval = 750;
      };

      selection = {
        save_to_clipboard = true;
      };

      # Scrolling
      scrolling = {
        history = 10000;
        multiplier = 3;
      };

      # Mouse
      mouse = {
        hide_when_typing = true;
      };

      # Live config reload
      general.live_config_reload = true;

    };
  };
}
