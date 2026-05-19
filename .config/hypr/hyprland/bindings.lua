local mainMod = "SUPER"
local terminal = "kitty"
local fileManager = "nautilus"
local menu = "pkill rofi || rofi -show combi"
local lockcmd = "hyprlock"
local suspendcmd = "killall -STOP Hyprland & sleep 4 & systemctl suspend"

hl.config({
    binds = {
        allow_workspace_cycles = true,
        movefocus_cycles_groupfirst = false,
    },
})

hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("firefox"))
hl.bind(mainMod .. " + F", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + G", hl.dsp.exec_cmd("~/.config/rofi/scripts/rofi-file-selector/rofi-file-selector.sh"))
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd("~/.local/bin/launch-clipse"))
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("code"))
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd("gnome-calendar"))

hl.bind(mainMod .. " + Z", hl.dsp.exec_cmd("zeditor"))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("killall waybar && waybar & disown"))
hl.bind(mainMod .. " + I", hl.dsp.exec_cmd("~/.local/bin/omarchy-launch-wifi"))
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd("~/.local/bin/omarchy-launch-audio-mixer"))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + O", hl.dsp.exec_cmd("hyprctl dispatch exit"))
hl.bind(mainMod .. " + S", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + M", hl.dsp.window.fullscreen(1))
hl.bind(mainMod .. " + Super_L", hl.dsp.exec_cmd(menu), { release = true })
hl.bind("SUPER_L", hl.dsp.exec_cmd(""), { release = true })

hl.bind("SUPER + N", hl.dsp.submap("notifications"))
hl.define_submap("notifications", function()
    hl.bind("M", hl.dsp.exec_cmd("swaync-client -d"))
    hl.bind("M", hl.dsp.submap("reset"))
    hl.bind("C", hl.dsp.exec_cmd("swaync-client -C"))
    hl.bind("C", hl.dsp.submap("reset"))
    hl.bind("T", hl.dsp.exec_cmd("swaync-client -t"))
    hl.bind("T", hl.dsp.submap("reset"))
end)

hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "r" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "u" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "d" }))

hl.bind(mainMod .. " + TAB", hl.dsp.focus({ workspace = "previous" }))
hl.bind(mainMod .. " + SHIFT + TAB", hl.dsp.focus({ workspace = "next" }))

hl.bind(mainMod .. " + bracketleft", hl.dsp.window.resize({ x = -100, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + bracketright", hl.dsp.window.resize({ x = 100, y = 0, relative = true }), { repeating = true })

for i = 1, 9 do
    hl.bind(mainMod .. " + " .. i, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
end
hl.bind(mainMod .. " + minus", hl.dsp.workspace.toggle_special("hidden"))
hl.bind(mainMod .. " + SHIFT + minus", hl.dsp.window.move({ workspace = "special:hidden", silent = true }))

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag())
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize())

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"),
    { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
    { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
    { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
    { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl s 10%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 10%-"), { locked = true, repeating = true })

hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

hl.bind("switch:on:Lid Switch",
    hl.dsp.exec_cmd("(pidof " .. lockcmd .. " || " .. lockcmd .. ") & sleep 1 && hyprctl dispatch dpms off"),
    { locked = true })
hl.bind("switch:off:Lid Switch", hl.dsp.exec_cmd("hyprctl dispatch dpms on"), { locked = true })
hl.bind(mainMod .. " + escape",
    hl.dsp.exec_cmd("(pidof " .. lockcmd .. " || " .. lockcmd .. ") & sleep 1 && hyprctl dispatch dpms off"),
    { locked = true })

hl.bind("XF86PowerDown", hl.dsp.exec_cmd(suspendcmd), { locked = true })
hl.bind("XF86PowerOff", hl.dsp.exec_cmd(suspendcmd), { locked = true })
hl.bind("XF86Suspend", hl.dsp.exec_cmd(suspendcmd), { locked = true })
hl.bind("XF86Hibernate", hl.dsp.exec_cmd(suspendcmd), { locked = true })

hl.bind("PRINT",
    hl.dsp.exec_cmd(
        "grim -g \"$(hyprctl clients -j | jq -r \".[] | select(.workspace.id | IN($(hyprctl -j monitors | jq 'map(.activeWorkspace.id) | join(\", \")' | tr -d \\\")))\" | jq -r \".at, .size\" | jq -s \"add\" | jq -r '\"\\(.[0]), \\(.[1]) \\(.[2])x\\(.[3])\"'| slurp)\" - | satty --copy-command wl-copy --filename - --fullscreen --output-filename ~/Pictures/Screenshots/satty-$(date '+%Y%m%d-%H:%M:%S').png"))

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace",
})
hl.gesture({
    fingers = 3,
    direction = "horizontal",
    mods = "SHIFT",
    action = "move",
})
-- TODO fix
hl.gesture({
    fingers = 3,
    direction = "down",
    action = function()
        hl.dsp.focus({ monitor = "u" })
    end
})
hl.gesture({
    fingers = 3,
    direction = "up",
    action = function()
        hl.dsp.focus({ monitor = "d" })
    end
})
-- hl.gesture({
--     fingers = 3,
--     direction = "up",
--     action = "dispatcher",
--     -- TODO: manual review — extra gesture field "focusmonitor"
--     -- TODO: manual review — extra gesture field "d"
-- })
-- hl.gesture({
--     fingers = 3,
--     direction = "down",
--     mods = "SHIFT",
--     action = "move",
--     -- TODO: manual review — extra gesture field "mon:u"
-- })
-- hl.gesture({
--     fingers = 3,
--     direction = "up",
--     mods = "SHIFT",
--     action = "move",
--     -- TODO: manual review — extra gesture field "mon:d"
-- })
