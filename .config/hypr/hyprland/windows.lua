hl.window_rule({
    match = {
        float = 0,
        fullscreen = 1,
    },
})

hl.window_rule({
    match = {
        tag = "floating-window",
    },
    float = true,
    center = true,
    size = "800 600",
})

hl.window_rule({
    match = {
        class = "(blueberry.py|Impala|Wiremix|org.gnome.NautilusPreviewer|com.gabm.satty|Omarchy|About|TUI.float)",
    },
    tag = "+floating-window",
})

hl.window_rule({
    match = {
        class = "(xdg-desktop-portal-gtk|sublime_text|DesktopEditors|org.gnome.Nautilus)",
        title =
        "^(Open.*Files?|Open [F|f]older.*|Save.*Files?|Save.*As|Save|All Files|.*wants to [open|save].*|[C|c]hoose.*)",
    },
    tag = "+floating-window",
})

hl.window_rule({
    match = {
        class = "org.gnome.Calculator",
    },
    float = true,
})

hl.window_rule({
    match = {
        title = "^(Save As)$",
    },
    float = true,
    size = "50% 80%",
})

hl.window_rule({
    match = {
        title = "(.*)(Progress)(.*)",
    },
    float = true,
})

hl.window_rule({
    match = {
        title = ".*Progress.*",
    },
    workspace = "silent special:hidden",
})

hl.window_rule({
    match = {
        title = "(.*)(fzf\\-nova)(.*)",
    },
    float = true,
})

hl.window_rule({
    match = {
        title = "(.*)(Text Import)(.*)",
    },
    float = true,
})

hl.window_rule({
    match = {
        class = ".*",
    },
    suppress_event = "maximize",
})
