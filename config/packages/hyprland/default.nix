{pkgs, lib, config, inputs, ... }:
let startupScript = pkgs.pkgs.writeShellScriptBin "start.sh" ''
#!/usr/bin/env bash
${pkgs.waybar}/bin/waybar &
${pkgs.swww}/bin/swww init &
sleep 1

${pkgs.swww}/bin/swww img ${./wallpaper.jpg} &
${pkgs.networkmanagerapplet}/bin/nm-applet --indicator &

${pkgs.dunst}/bin/dunst

  '';
in
{
  home.packages = with pkgs; [
      wl-clipboard
      grim
      slurp
      swww
      rofi-wayland
      waybar
  ];

  wayland = {
    windowManager = {
      hyprland = {
        enable = true;
        package = inputs.hyprland.packages.${pkgs.system}.hyprland;
        extraConfig = /* hyprlang */ ''
          monitor=,preferred,auto,auto
          env = XCURSOR_SIZE,24
          env = QT_QPA_PLATFORMTHEME,qt5ct # change to qt6ct if you have that
          input {
            kb_layout = us
            kb_variant =
            kb_model =
            kb_options =
            kb_rules =

            follow_mouse = 1

            touchpad {
                natural_scroll = no
            }

            sensitivity = 0 # -1.0 to 1.0, 0 means no modification.
          }
          general {
            # See https://wiki.hyprland.org/Configuring/Variables/ for more

            gaps_in = 5
            gaps_out = 20
            border_size = 2
            col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
            col.inactive_border = rgba(595959aa)

            layout = dwindle

            # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
            allow_tearing = false
          }

          decoration {
            # See https://wiki.hyprland.org/Configuring/Variables/ for more

            rounding = 10
            
            blur {
                enabled = true
                size = 3
                passes = 1
            }

            drop_shadow = yes
            shadow_range = 4
            shadow_render_power = 3
            col.shadow = rgba(1a1a1aee)
          }
          animations {
            enabled = yes

            # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

            bezier = myBezier, 0.05, 0.9, 0.1, 1.05

            animation = windows, 1, 7, myBezier
            animation = windowsOut, 1, 7, default, popin 80%
            animation = border, 1, 10, default
            animation = borderangle, 1, 8, default
            animation = fade, 1, 7, default
            animation = workspaces, 1, 6, default
          }

          dwindle {
              # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
              pseudotile = yes # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
              preserve_split = yes # you probably want this
          }

          master {
              # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
              new_is_master = true
          }

          gestures {
              # See https://wiki.hyprland.org/Configuring/Variables/ for more
              workspace_swipe = on
          }

          misc {
              # See https://wiki.hyprland.org/Configuring/Variables/ for more
              force_default_wallpaper = -1 # Set to 0 or 1 to disable the anime mascot wallpapers
          }

          # Example per-device config
          # See https://wiki.hyprland.org/Configuring/Keywords/#executing for more
          device {
              name = epic-mouse-v1
              sensitivity = -0.5
          }

          windowrulev2 = suppressevent maximize, class:.* # You'll probably like this.

        '';
        settings = {
           "$mod" = "SUPER";
            bind =
              [
                "$mod, C, killactive"
                "$mod, E, exec, thunar"
                "$mod, F, exec, firefox"
                "$mod, J, togglesplit"
                "$mod, M, exit"
                "$mod, Q, exec, kitty"
                "$mod, V, togglefloating"
                # Rofi
                "$mode, space,  exec, rofi -show drun -show-icons"
                # move focus
                "$mod, left, movefocus, l"
                "$mod, right, movefocus, r"
                "$mod, up, movefocus, u"
                "$mod, down, movefocus, d"
                # scratchpad
                "$mod,  S, togglespecialworkspace, magic"
                "$mod, SHIFT, S, movetoworkspace, special:magic"
                # Scroll through existing workspaces with mainMod + scroll
                "$mod,  mouse_down, workspace, e+1"
                "$mod, mouse_up, workspace, e-1"
              ]
            ++ (
            # workspaces
            # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
            builtins.concatLists (builtins.genList (
                x: let
                  ws = let
                    c = (x + 1) / 10;
                  in
                    builtins.toString (x + 1 - (c * 10));
                  in [
                    "$mod, ${ws}, workspace, ${toString (x + 1)}"
                    "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
                    ]
                )
            10)
          );

          bindm = 
            [
              "$mod, mouse:272, movewindow"
              "mode,  mouse:273, resizewindow"
            ];

          exec-once = "${startupScript}/bin/start.sh";
          
        };
      };
    };
  };


}