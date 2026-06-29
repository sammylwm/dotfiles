from libqtile import layout

from libqtile.config import Match

layouts = [
    # layout.Columns(border_focus_stack=["#d75f5f", "#8f3d3d"], border_width=4),
    # layout.Max(),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    layout.Bsp(
        fair=False,
        margin=5,
        border_width=2,
        border_focus="#89b4fa",
    )
    # layout.Matrix(),
    # layout.MonadTall(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

from libqtile import hook
from libqtile.config import Match

# Правила для автоматического переключения приложений в режим floating (плавающий)
float_rules = [
    *layout.Floating.default_float_rules,
    Match(wm_class='confirm'),
    Match(wm_class='dialog'),
    Match(wm_class='download'),
    Match(wm_class='error'),
    Match(wm_class='file_progress'),
    Match(wm_class='notification'),
    Match(wm_class='splash'),
    Match(wm_class='toolbar'),
    Match(wm_class='confirmreset'),
    Match(wm_class='makebranch'),
    Match(wm_class='maketag'),
    Match(wm_class='ssh-askpass'),
    Match(title='branchdialog'),
    Match(title='pinentry'),
    Match(wm_class='pinentry-gtk-2'),
    Match(wm_class='Nitrogen'),       # Пример: окно выбора обоев
    Match(wm_class='Nm-connection-editor'), # Окно настроек сети
]

# Хук, который центрирует любое окно, перешедшее в плавающий режим
@hook.subscribe.client_new
def floating_size(client):
    if client.floating:
        client.center()

# Убедитесь, что ваш floating_layout использует настроенные правила
floating_layout = layout.Floating(float_rules=float_rules)
