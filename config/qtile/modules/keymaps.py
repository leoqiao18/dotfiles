from libqtile.command import lazy
from libqtile.config import Click, Drag, Key, KeyChord


mod = "mod4"
myTerm = "kitty"
myBrowser = "qutebrowser"
emacs = "emacsclient -c"


def emacs_eval(s):
    return f"{emacs} -e '{s}'"


mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()
    ),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

window_navigation = [
    Key([mod], "h", lazy.layout.left()),
    Key([mod], "l", lazy.layout.right()),
    Key([mod], "j", lazy.layout.down()),
    Key([mod], "k", lazy.layout.up()),
]

window_displacement = [
    Key([mod], "Return", lazy.layout.swap_main()),
    Key([mod, "shift"], "h", lazy.layout.swap_left()),
    Key([mod, "shift"], "l", lazy.layout.swap_right()),
    Key([mod, "shift"], "j", lazy.layout.swap_down()),
    Key([mod, "shift"], "k", lazy.layout.swap_up()),
]

window_dimension = [
    Key([mod, "control"], "h", lazy.layout.grow_left()),
    Key([mod, "control"], "l", lazy.layout.grow_right()),
    Key([mod, "control"], "j", lazy.layout.grow_down()),
    Key([mod, "control"], "k", lazy.layout.grow_up()),
    Key([mod, "control"], "n", lazy.layout.normalize()),
]

window_toggles = [
    Key([mod, "shift"], "c", lazy.window.kill()),
    Key([mod], "space", lazy.next_layout()),
    Key([mod], "t", lazy.window.toggle_floating()),
    Key([mod], "m", lazy.window.toggle_minimize()),
    Key([mod, "shift"], "space", lazy.window.toggle_fullscreen()),
]

qtilectl = [
    Key([mod, "shift"], "r", lazy.restart()),
    Key([mod, "shift"], "q", lazy.shutdown()),
]

rofi_spawns = [
    KeyChord(
        [mod],
        "p",
        [
            Key([], "p", lazy.spawn("rofi -show drun")),
            Key([], "w", lazy.spawn("rofi -show window")),
            Key([], "r", lazy.spawn("rofi -show run")),
            Key([], "s", lazy.spawn("rofi-systemd")),
        ],
    ),
]

application_spawns = [
    Key([mod, "shift"], "Return", lazy.spawn(myTerm)),
    Key([mod], "b", lazy.spawn(myBrowser)),
]

audioctl = [
    Key([], "XF86AudioRaiseVolume", lazy.spawn("volctl --up")),
    Key([], "XF86AudioLowerVolume", lazy.spawn("volctl --down")),
    Key([], "XF86AudioMute", lazy.spawn("volctl --mute")),
    Key([], "XF86AudioMicMute", lazy.spawn("micvol --mute")),
    Key([mod], "v", lazy.spawn("volctl --up")),
    Key([mod, "shift"], "v", lazy.spawn("volctl --down")),
    Key([mod, "ctrl"], "v", lazy.spawn("volctl --mute")),
    Key([], "", lazy.spawn("micvol --mute")),
]

mediactl = [
    Key([mod], "Down", lazy.spawn("playerctl play-puase")),
    Key([mod], "Left", lazy.spawn("playerctl previous")),
    Key([mod], "Down", lazy.spawn("playerctl next")),
]

brightctl = [
    Key([], "XF86MonBrightnessUp", lazy.spawn("brightctl --up")),
    Key([], "XF86MonBrightnessDown", lazy.spawn("brightctl --down")),
]

emacs = [
    KeyChord(
        [mod],
        "e",
        [
            Key([], "a", lazy.spawn(emacs_eval("(org-todo-list)"))),
            Key([], "b", lazy.spawn(emacs_eval("(ibuffer)"))),
            Key([], "d", lazy.spawn(emacs_eval("(dired nil)"))),
            Key([], "e", lazy.spawn(emacs)),
            Key([], "t", lazy.spawn(emacs_eval("(org-roam-dailies-capture-today)"))),
            Key([], "v", lazy.spawn(emacs_eval("(+vterm/here nil)"))),
        ],
    ),
]

keys = [
    *window_navigation,
    *window_displacement,
    *window_dimension,
    *window_toggles,
    *qtilectl,
    *rofi_spawns,
    *application_spawns,
    *audioctl,
    *mediactl,
    *brightctl,
]
