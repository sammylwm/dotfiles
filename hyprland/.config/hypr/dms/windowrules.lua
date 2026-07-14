-- DMS Window Rules — managed by DankMaterialShell
-- Do not edit manually; changes may be overwritten

hl.workspace_rule({ workspace = "special:happ", on_created_empty = "happ" })
hl.workspace_rule({ workspace = "special:tg", on_created_empty = "materialgram" })
hl.workspace_rule({ workspace = "special:music", on_created_empty = "yandex-music" })
hl.workspace_rule({ workspace = "special:localsend", on_created_empty = "localsend" })

hl.window_rule({
  name = "kando",
  match = {
      class = "menu.kando.Kando",
      title = "Kando Menu"
  },
  no_blur = true,
  opaque = true,
  move = {0, 0},
  rounding = 0,
  size = { "100%", "100%" },
  border_size = 0,
  no_anim = true,
  float = true,
  pin = true
})
