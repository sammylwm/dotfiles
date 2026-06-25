from libqtile.config import Key
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

from env import mod

keys = [
    Key([mod], "Return", lazy.spawn(guess_terminal()), desc="Launch terminal"),
    Key([mod], "b", lazy.spawn("firefox"), desc="Launch firefox"),
]