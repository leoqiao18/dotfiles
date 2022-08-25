# credits: the-argus
# TODO: my own statusbar, use this to setup qtile for now.

from libqtile import bar, widget
from libqtile.config import Screen
from libqtile.lazy import lazy

from modules.groups import borderline
from modules.themes import nordList

fontinfo = dict(
    font="VictorMono Nerd Font Semibold",
    fontsize=12,
    padding=3,
)

ROFI = "rofi -no-lazy-grab -show drun -modi drun"

groupbox = [
    widget.GroupBox,
    {
        "active": nordList[0],
        "block_highlight_text_color": nordList[1],
        "disable_drag": True,
        "font": fontinfo["font"],
        "fontsize": 16,
        "foreground": nordList[2],
        "hide_unused": True,
        "highlight_color": [nordList[0], nordList[3]],
        "highlight_method": "block",
        "inactive": nordList[0],
        "padding": fontinfo["padding"],
        "rounded": True,
        "spacing": 5,
        "this_current_screen_border": nordList[4],
        "urgent_alert_method": "block",
        "urgent_border": nordList[7],
        "urgent_text": nordList[7],
        "use_mouse_wheel": True,
    },
]

windowname = [
    widget.WindowName,
    {
        "background": nordList[2],
        "center_aligned": True,
        "font": fontinfo["font"],
        "fontsize": fontinfo["fontsize"],
        "format": "{name}",
        "max_chars": 35,
        "padding": 3,
    },
]

systray = [
    widget.Systray,
    {
        "background": nordList[2],
        "foreground": nordList[5],
        "theme_path": "/nix/store/g8pz3vf8ih10h3hw50rv0gpki9k72j2q-Whitesur-icon-theme-2022-03-18/share/icons/WhiteSur/",
    },
]

spacer_small = [
    widget.Spacer,
    {
        "length": 5,
        # these values are used by style func, not qtile
        "inheirit": True,
        "is_spacer": True,
        "use_separator": False,
    },
]

logo = [
    widget.TextBox,
    {
        "font": fontinfo["font"],
        "background": nordList[8],
        "fontsize": 21,
        "foreground": nordList[1],
        "mouse_callbacks": {"Button1": lazy.spawn(ROFI)},
        "padding": -1.0,
        "text": " \ue928",
    },
]

layout = [
    widget.CurrentLayoutIcon,
    {
        **fontinfo,
        "background": nordList[3],
        "foreground": nordList[1],
        "custom_icon_paths": "./icons",
        "scale": 0.63,
    },
]


cpu = [
    widget.CPU,
    {
        **fontinfo,
        "background": nordList[10],
        "foreground": nordList[1],
        "format": "\ue9aa {freq_current}GHz {load_percent}%",
    },
]

net = [
    widget.Net,
    {
        **fontinfo,
        "background": nordList[4],
        "format": "\ue640 {down} \u2191 {up}",
        "interface": "wlan0",
        "update_interval": 3,
    },
]

mem = [
    widget.Memory,
    {
        **fontinfo,
        "format": "\ue949 {MemUsed:.2f}/{MemTotal:.2f}{mm}",
        "measure_mem": "G",
        "update_interval": 1.0,
    },
]

mpris = [
    widget.Mpris2,
    {
        **fontinfo,
        "foreground": nordList[1],
        "background": nordList[9],
        "max_chars": 15,
        "paused_text": "\uf8e4 {track}",
        "playing_text": "\uf90b {track}",
    },
]

batt = [
    widget.Battery,
    {
        **fontinfo,
        "background": nordList[5],
        "foreground": nordList[1],
        "charge_char": "\ue63c ",
        "discharge_char": "\ue3e6 ",
        "empty_char": "\uf244 ",
        "full_char": "\uf240 ",
        "unknown_char": "\ue645 ",
        "format": "{char} {percent:2.0%} ({watt:.2f}W) ",
        "low_background": nordList[7],
        "low_foreground": nordList[1],
        "low_percentage": 0.30,
        "show_short_text": False,
    },
    widget.BatteryIcon,
    {
        "theme_path": "/nix/store/g8pz3vf8ih10h3hw50rv0gpki9k72j2q-Whitesur-icon-theme-2022-03-18/share/icons/WhiteSur",
    },
]

datetime = [
    widget.Clock,
    {
        **fontinfo,
        "background": nordList[6],
        "foreground": nordList[1],
        "format": "\ue8df %a, %B %e, %H:%M",
    },
]


def widgetlist():
    return [
        spacer_small,
        logo,
        groupbox,
        layout,
        windowname,
        mpris,
        cpu,
        # net,
        mem,
        systray,
        datetime,
        batt,
    ]


def style(widgetlist):
    styled = widgetlist[:]

    for index, wid in enumerate(widgetlist):
        end_sep = {
            "font": fontinfo["font"],
            "fontsize": 34,
            "padding": -1,
            "text": " \ue0b6",
        }

        if index < len(widgetlist) - 1:
            # end_sep["background"]=widgetlist[index+1][1].get("background", nordList[1])
            # end_sep["foreground"]=wid[1].get("background", nordList[1])

            end_sep["foreground"] = widgetlist[index + 1][1].get(
                "background", nordList[1]
            )
            end_sep["background"] = wid[1].get("background", nordList[1])

            if wid[1].get("is_spacer") and wid[1].get("inheirit"):
                bg = widgetlist[index + 1][1].get("background", nordList[1])
                wid[1]["background"] = bg
                end_sep["background"] = bg

            # insert separator before current
            if wid[1].get("use_separator", True):
                styled.insert(styled.index(wid) + 1, (widget.TextBox, end_sep))

    return [w[0](**w[1]) for w in styled]


def my_bar():
    return bar.Bar(
        [*style(widgetlist())],
        34,
        foreground=nordList[0],
        background=nordList[1],
        opacity=1.0,
        margin=[
            borderline["margin"],
            borderline["margin"],
            borderline["border_width"],
            borderline["margin"],
        ],
    )


widget_defaults = dict(
    **fontinfo,
)

extension_defaults = widget_defaults.copy()

screens = [
    Screen(top=my_bar()),
]
