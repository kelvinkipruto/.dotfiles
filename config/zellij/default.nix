{ ... }:
{
  xdg.configFile."zellij/config.kdl".text = ''
    themes {
      tokyo-night {
        fg 192 202 245
        bg 26 27 38
        black 21 22 30
        white 169 177 214
        red 247 118 142
        green 158 206 106
        yellow 224 175 104
        blue 122 162 247
        magenta 187 154 247
        orange 255 158 100
        cyan 125 207 255
      }
    }

    theme "tokyo-night"
    default_mode "locked"
    mouse_mode true
    copy_on_select true
    pane_frames true
    scroll_buffer_size 10000
    show_startup_tips false
    show_release_notes false
  '';
}
