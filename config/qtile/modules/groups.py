from libqtile import layout
from libqtile.command import lazy
from libqtile.config import DropDown, Group, Key, KeyChord, Match, ScratchPad

from modules.keymaps import mod, keys
from modules.themes import palette

groups = [Group(f"{i}", label="") for i in range(1, 9)]

for i in groups:
    keys.extend(
        [
            # mod + letter of group = switch to group
            Key([mod], i.name, lazy.group[i.name].toscreen()),
            # mod + shift + letter of group = move focused window to group
            Key([mod, "shift"], i.name, lazy.window.togroup(i.name)),
        ]
    )

borderline = dict(
    border_focus=palette["cyan"],
    border_normal=palette["black"],
    border_width=3,
    margin=10,
)

layouts = [
    layout.Columns(
        **borderline,
        border_focus_stack=palette["yellow"],
        border_normal_stack=palette["magenta"],
        border_on_single=True,
    ),
    layout.Max(**borderline),
]

floating_layout = layout.Floating(
    **borderline,
    float_rules=[
        *layout.Floating.default_float_rules,
        Match(wm_class="confirm"),
        Match(wm_class="dialog"),
        Match(wm_class="download"),
        Match(wm_class="error"),
        Match(wm_class="file_progress"),
        Match(wm_class="notification"),
        Match(wm_class="splash"),
        Match(wm_class="toolbar"),
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(title="branchdialog"),  # gitk
        Match(wm_class="pinentry"),  # GPG key password entry
        Match(title="Picture-in-Picture"),  # FireFox
        Match(wm_class="ssh-askpass"),  # ssh-askpass
    ],
)

next_maximum = {
    "x": 0.02,
    "y": 0.02,
    "width": 0.95,
    "height": 0.95,
    "opacity": 1.00,
    "on_focus_lost_hide": False,
}

groups.append(
    ScratchPad(
        "SP",
        [
            DropDown(
                "Discord",
                "discord",
                match=Match(wm_class="discord"),
                **next_maximum,
            ),
            DropDown(
                "Slack",
                "slack",
                match=Match(wm_class="slack"),
                **next_maximum,
            ),
            DropDown("Music", "spotify", **next_maximum),
            DropDown("Volume", "pavucontrol", **next_maximum),
        ],
    )
)

keys.extend(
    [
        KeyChord(
            [mod],
            "d",
            [
                Key([], "d", lazy.group["SP"].dropdown_toggle("Discord")),
                Key([], "s", lazy.group["SP"].dropdown_toggle("Slack")),
                Key([], "m", lazy.group["SP"].dropdown_toggle("Music")),
                Key([], "v", lazy.group["SP"].dropdown_toggle("Volume")),
            ],
        )
    ]
)
