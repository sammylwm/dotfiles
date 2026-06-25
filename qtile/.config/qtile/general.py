from libqtile.backend.wayland import InputConfig
from libqtile.config import Drag, Click
from libqtile.lazy import lazy

from env import mod

from libqtile.backend.wayland import InputConfig


wl_input_rules = {
    "type:keyboard": InputConfig(
        kb_layout="us,ru",
        kb_options="grp:alt_shift_toggle",
    ),
    "type:touchpad": InputConfig(tap=True, natural_scroll=True, dwt=True),
}
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
floats_kept_above = True
cursor_warp = False

auto_fullscreen = True
focus_on_window_activation = "smart"
focus_previous_on_window_remove = False
reconfigure_screens = True
auto_minimize = True
wl_xcursor_theme = None
wl_xcursor_size = 24

idle_timers = []  # type: list
idle_inhibitors = []  # type: list

wmname = "LG3D"
