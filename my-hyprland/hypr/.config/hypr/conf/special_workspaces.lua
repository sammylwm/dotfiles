hl.workspace_rule({ workspace = "special:happ", on_created_empty = "happ" })
hl.workspace_rule({ workspace = "special:tg", on_created_empty = "materialgram" })
hl.workspace_rule({ workspace = "special:music", on_created_empty = "yandex-music" })
hl.workspace_rule({ workspace = "special:localsend", on_created_empty = "localsend" })

hl.bind("SUPER + D", hl.dsp.workspace.toggle_special("tg"))
hl.bind("SUPER + L", hl.dsp.workspace.toggle_special("localsend"))
hl.bind("SUPER + M", hl.dsp.workspace.toggle_special("music"))
hl.bind("SUPER + S", hl.dsp.workspace.toggle_special("happ"))
