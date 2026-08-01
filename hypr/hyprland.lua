-- autostart
hl.on("hyprland.start", function ()
  hl.exec_cmd("waybar")
  hl.exec_cmd('gsettings set org.gnome.desktop.interface gtk-theme "adw-gtk3-dark"')
  hl.exec_cmd('gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"')
  hl.exec_cmd("hypridle")
  hl.exec_cmd("awww-daemon")
  hl.exec_cmd("hyprpolkitagent")
  -- hl.exec_cmd("~/.config/waybar/scripts/launch.sh")
  -- hl.exec_cmd("hyprpaper")
end)

-- Monitors
hl.monitor({
  output = "eDP-1",
  mode = "1920x1080@60",
  position = "auto",
  scale = 1,
})

hl.monitor({
  output = "HDMI-A-1",
  mode = "1920x1080@75",
  position = "auto",
  scale = 1,
})

-- my programs
local terminal    = "kitty"
local fileManager = "nautilus"
local menu        = "wofi --show drun"
local browser = "firefox"
local mainMod = "SUPER"

-- look and feel
hl.config({
    general = {
        gaps_in  = 5,
        gaps_out = 10,

        border_size = 2,

        col = {
            active_border   = "rgba(3b4261ff)",
            inactive_border = "rgba(0a0b0fcc)",
        },

        resize_on_border = false,
        allow_tearing = false,
        layout = "dwindle",
    },

    decoration = {
        rounding = 19,
        rounding_power = 13,
        active_opacity = 0.93,
        inactive_opacity = 0.90,
        dim_inactive = true,
        dim_strength = 0.15,

        shadow = {
            enabled      = true,
            range        = 2,
            render_power = 3,
            color        = 0xee1a1a1a,
        },

        blur = {
            enabled = true,
            size = 6,
            passes = 2,
            new_optimizations = true,
            ignore_opacity = true,
            noise = 0.0117,
            contrast = 0.8916,
            brightness = 0.8172,
            vibrancy = 0.1696,
            vibrancy_darkness = 1
            },
    },

    animations = {
        enabled = true,
    },
})

hl.curve("linear",         { type = "bezier", points = { {0, 0}, {1, 1} } })
hl.curve("md3_standard",   { type = "bezier", points = { {0.2, 0}, {0, 1} } })
hl.curve("md3_decel",      { type = "bezier", points = { {0.05, 0.7}, {0.1, 1} } })
hl.curve("md3_accel",      { type = "bezier", points = { {0.3, 0}, {0.8, 0.15} } })
hl.curve("overshot",       { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.1} } })
hl.curve("crazyshot",      { type = "bezier", points = { {0.1, 1.5}, {0.76, 0.92} } })
hl.curve("hyprnostretch",  { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.0} } })
hl.curve("fluent_decel",   { type = "bezier", points = { {0.1, 1}, {0, 1} } })
hl.curve("easeInOutCirc",  { type = "bezier", points = { {0.85, 0}, {0.15, 1} } })
hl.curve("easeOutCirc",    { type = "bezier", points = { {0, 0.55}, {0.45, 1} } })
hl.curve("easeOutExpo",    { type = "bezier", points = { {0.16, 1}, {0.3, 1} } })

hl.animation({ leaf = "windows",          enabled = true, speed = 3,   bezier = "md3_decel",   style = "popin 60%" })
hl.animation({ leaf = "border",           enabled = true, speed = 10,  bezier = "default" })
hl.animation({ leaf = "fade",             enabled = true, speed = 2.5, bezier = "md3_decel" })
hl.animation({ leaf = "workspaces",       enabled = true, speed = 3.5, bezier = "easeOutExpo", style = "slide" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 3,   bezier = "md3_decel",   style = "slidevert" })

hl.config({
    cursor = {
        hide_on_key_press = true,
        warp_on_change_workspace = 1
    },
    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo = false
    },
})

-- windowrules
hl.window_rule({
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float  = true,
        fullscreen = false,
        pin        = false,
    },
    no_focus = true
})

hl.window_rule({
    name  = "move-hyperland-run",
    match = { class = "^(hyperland-run)$" },
    float = true,
    move  = "20 monitor_h-120",
})

hl.window_rule({
    name  = "bluetui",
    match = { class = "^(bluetui -e bluetui)$" },
    float = true,
})

hl.window_rule({
    name  = "float-satty",
    match = { class = "^(com.gabm.satty)$" },
    float = true,
})

-- keybindings
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + W", hl.dsp.window.close())
hl.bind(mainMod .. " + F", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + T", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + O", hl.dsp.exec_cmd("obsidian"))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("kitty -e nvim"))
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("spotify"))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen(0))

-- Toggle Opaque (bindd usa a propriedade description)
hl.bind(mainMod .. " + BACKSPACE", hl.dsp.exec_cmd("hyprctl --batch 'dispatch setprop active opaque toggle; dispatch setprop active noblur toggle;'"), { description = "Toggle opaque and noblur" })

for i = 1, 9 do
    hl.bind(mainMod .. " + " .. i,         hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + ALT + right", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + ALT + left",  hl.dsp.focus({ workspace = "e-1" }))

hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.window.move({ direction = "down" }))

hl.bind(mainMod .. " + EQUAL",         hl.dsp.exec_cmd("hyprctl dispatch resizeactive 40 0"),   { repeating = true })
hl.bind(mainMod .. " + MINUS",         hl.dsp.exec_cmd("hyprctl dispatch resizeactive -40 0"),  { repeating = true })
hl.bind(mainMod .. " + SHIFT + EQUAL", hl.dsp.exec_cmd("hyprctl dispatch resizeactive 0 40"),   { repeating = true })
hl.bind(mainMod .. " + SHIFT + MINUS", hl.dsp.exec_cmd("hyprctl dispatch resizeactive 0 -40"),  { repeating = true })

hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),        { locked = true, repeating = true })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),       { locked = true })
hl.bind("XF86AudioPlay",         hl.dsp.exec_cmd("playerctl play-pause"),                             { locked = true })
hl.bind("XF86AudioNext",         hl.dsp.exec_cmd("playerctl next"),                                   { locked = true })
hl.bind("XF86AudioPrev",         hl.dsp.exec_cmd("playerctl previous"),                               { locked = true })

hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl set +5%"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"), { locked = true, repeating = true })

hl.bind("Print", hl.dsp.exec_cmd("bash -c 'grim -g \"$(slurp)\" - | satty --filename - --output-filename ~/Pictures/Screenshots/satty-$(date +%Y%m%d-%H%M%S).png'"))

hl.bind(mainMod .. " + ALT + SPACE", hl.dsp.exec_cmd("~/.config/hypr/scripts/seletor_wallpaper.sh"))
hl.bind(mainMod .. " + SHIFT + W",   hl.dsp.exec_cmd("~/.config/hypr/scripts/mudar_wallpaper.sh"))

hl.bind(mainMod .. " + END", hl.dsp.submap("power"))
hl.define_submap("power", function()
    hl.bind("S", hl.dsp.exec_cmd("hyprctl dispatch submap reset && systemctl suspend"))
    hl.bind("D", hl.dsp.exec_cmd("systemctl poweroff"))
    hl.bind("R", hl.dsp.exec_cmd("systemctl reboot"))
    hl.bind("L", hl.dsp.exec_cmd("hyprctl dispatch submap reset && hyprlock"))
    hl.bind("ESCAPE", hl.dsp.submap("reset"))
    hl.bind("RETURN", hl.dsp.submap("reset"))
end)
