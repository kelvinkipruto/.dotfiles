{
  programs.alacritty = {
    enable = true;
    settings = {
      # Window configuration
      window = {
        opacity = 0.95;
        padding = {
          x = 8;
          y = 8;
        };
        decorations = "full";
        startup_mode = "Windowed";
      };

      # Font configuration
      font = {
        normal = {
          family = "MesloLGS NF";
          style = "Regular";
        };
        bold = {
          family = "MesloLGS NF";
          style = "Bold";
        };
        italic = {
          family = "MesloLGS NF";
          style = "Italic";
        };
        bold_italic = {
          family = "MesloLGS NF";
          style = "Bold Italic";
        };
        size = 13;
      };

      # Color scheme - Tokyo Night theme
      colors = {
        primary = {
          background = "#1a1b26";
          foreground = "#c0caf5";
        };
        normal = {
          black = "#15161e";
          red = "#f7768e";
          green = "#9ece6a";
          yellow = "#e0af68";
          blue = "#7aa2f7";
          magenta = "#bb9af7";
          cyan = "#7dcfff";
          white = "#a9b1d6";
        };
        bright = {
          black = "#414868";
          red = "#f7768e";
          green = "#9ece6a";
          yellow = "#e0af68";
          blue = "#7aa2f7";
          magenta = "#bb9af7";
          cyan = "#7dcfff";
          white = "#c0caf5";
        };
        indexed_colors = [
          { index = 16; color = "#ff9e64"; }
          { index = 17; color = "#db4b4b"; }
        ];
      };

      # Cursor configuration
      cursor = {
        style = {
          shape = "Block";
          blinking = "On";
        };
        blink_interval = 750;
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

      # Selection
      selection = {
        save_to_clipboard = true;
      };

      # Live config reload
      general.live_config_reload = true;

    };
  };
}
