local terminal = "kitty"

hl.on("hyprland.start", function()
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    hl.exec_cmd("hyprpaper & hypridle")
    hl.exec_cmd("swaync")
    hl.exec_cmd("python ~/Documents/FOSS/gnome-next-meeting-applet/gnma/applet.py")
    hl.exec_cmd("waybar")
    hl.exec_cmd("wl-clip-persist --clipboard regular&")
    hl.exec_cmd("clipse -listen")
    hl.exec_cmd("firefox", { workspace = "2 silent" })
    hl.exec_cmd(terminal, { workspace = "4 silent" })
    hl.exec_cmd("thunderbird", { workspace = "3 silent" })
    hl.exec_cmd("run_keybase", { workspace = "3 silent" })
    hl.exec_cmd("discord --start-minimized", { workspace = "3 silent" })
    hl.exec_cmd("zotero", { workspace = "5 silent" })
    hl.exec_cmd("io.gitlab.news_flash.NewsFlash --headless")
    hl.exec_cmd(
        "systemd-inhibit --who=\"Hyprland config\" --why=\"wlogout keybind\" --what=handle-power-key --mode=block sleep infinity & echo $! > /tmp/.hyprland-systemd-inhibit")
end)

hl.on("hyprland.shutdown", function()
    hl.exec_cmd("kill -9 \"$(cat /tmp/.hyprland-systemd-inhibit)")
end)
