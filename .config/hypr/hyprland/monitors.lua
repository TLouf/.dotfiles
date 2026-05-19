-- See https://wiki.hypr.land/Configuring/Basics/Monitors/

-- Laptop's monitor, mirrored on unknown displays by default

hl.monitor({
    output = "eDP-1",
    mode = "preferred",
    position = "auto-down",
    scale = "1",
})

hl.monitor({
    output = "",
    mode = "preferred",
    position = "auto",
    scale = "1",
    mirror = "eDP-1",
})

-- Usual monitors
hl.monitor({
    output = "desc:LG Electronics LG TV 0x01010101",
    mode = "preferred",
    position = "auto-up",
    scale = "2",
})

hl.monitor({
    output = "desc:LG Electronics LG TV SSCR2 0x01010101",
    mode = "preferred",
    position = "auto-up",
    scale = "2",
})

hl.monitor({
    output = "desc:AOC 27B3CA2 AUER29A004681",
    mode = "preferred",
    position = "auto-up",
    scale = "1",
})

-- UC3M projectors
hl.monitor({
    output = "desc:Seiko Epson Corporation EPSON PJ 0x01010101",
    mode = "1920x1080",
    -- mode = "2560x1440@60",
    -- mode = "preferred",
    --# As mirror of Wacom
    -- mode = "preferred",
    -- mirror = "desc:Wacom Tech Cintiq 16 0FQ00X1000775",
    position = "auto-up",
    scale = "1",
})

hl.monitor({
    output = "desc:RGB Systems Inc. dba Extron Electronics Extron HDMI",
    mode = "1920x1080",
    position = "auto-up",
    scale = "1",
    -- mirror = "desc:Wacom Tech Cintiq 16 0FQ00X1000775",
})

-- Wacom tablet. If change the following, also change input.tablet.output!
hl.monitor({
    output = "desc:Wacom Tech Cintiq 16 0FQ00X1000775",
    mode = "preferred",
    position = "auto-left",
    scale = "1",
    -- mirror = "eDP-1",
})

hl.workspace_rule({
    workspace = "1",
    -- monitor = "desc:Seiko Epson Corporation EPSON PJ 0x01010101",
    -- monitor = "desc:RGB Systems Inc. dba Extron Electronics Extron HDMI",
    monitor = "desc:AOC 27B3CA2 AUER29A004681",
    default = true,
    persistent = true,
})

hl.workspace_rule({
    workspace = "2",
    monitor = "eDP-1",
    default = true,
    persistent = true,
})

hl.workspace_rule({
    workspace = "3",
    monitor = "eDP-1",
    default = true,
    persistent = true,
})

hl.workspace_rule({
    workspace = "4",
    monitor = "eDP-1",
    default = true,
    persistent = true,
})

hl.workspace_rule({
    workspace = "5",
    monitor = "eDP-1",
    default = true,
    persistent = true,
})

hl.workspace_rule({
    workspace = "6",
    monitor = "desc:Wacom Tech Cintiq 16 0FQ00X1000775",
    default = true,
    persistent = true,
})
