# credits: the-argus
# TODO: my own statusbar, use this to setup qtile for now.
from os.path import exists

from libqtile import bar, widget
from libqtile.config import Screen
from libqtile.lazy import lazy

from modules.groups import borderline
from modules.themes import palette, nord

fontinfo = dict(
    font="JetBrainsMono Nerd Font",
    fontsize=14,
    padding=3,
)

ROFI = "rofi -no-lazy-grab -show drun -modi drun"

groupbox = [
    widget.GroupBox,
    {
        "font": fontinfo["font"],
        "padding": fontinfo["padding"],
        "fontsize": fontinfo["fontsize"],
        "foreground": palette["fg"],
        "background": nord[3],
        "highlight_method": "text",
        # "block_highlight_text_color": palette["white"],
        "active": palette["fg"],
        "inactive": palette["bg"],
        "rounded": False,
        "highlight_color": [nord[7], palette["cyan"]],
        "urgent_alert_method": "line",
        "urgent_text": palette["red"],
        "urgent_border": palette["red"],
        "disable_drag": True,
        "use_mouse_wheel": False,
        "hide_unused": False,
        "spacing": 5,
        "this_current_screen_border": palette["yellow"],
    },
]

windowname = [
    widget.WindowName,
    {
        "background": nord[1],
        "foreground": palette["fg"],
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
        "background": nord[7],
        "foreground": palette["fg"],
        # "theme_path": "/nix/store/lj3r058gwdnycp1fmbkj58anlg8cpx9z-Whitesur-icon-theme-2022-03-18/share/icons/WhiteSur/",
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
        "background": nord[7],
        "fontsize": 20,
        "foreground": palette["bg"],
        "mouse_callbacks": {"Button1": lazy.spawn(ROFI)},
        # "padding": 2.0,
        "text": "  \uf313 ",
    },
]

layout = [
    widget.CurrentLayoutIcon,
    {
        **fontinfo,
        "background": nord[2],
        "foreground": palette["fg"],
        "custom_icon_paths": "./icons",
        "scale": 0.63,
    },
]


cpu = [
    widget.CPU,
    {
        **fontinfo,
        "background": nord[2],
        "foreground": palette["fg"],
        "format": "\ue9aa {freq_current}GHz {load_percent}%",
    },
]

mem = [
    widget.Memory,
    {
        **fontinfo,
        "background": nord[2],
        "foreground": palette["fg"],
        "format": "\ue949 {MemUsed:.2f}/{MemTotal:.2f}{mm}",
        "measure_mem": "G",
        "update_interval": 1.0,
    },
]

batt = [
    widget.Battery,
    {
        **fontinfo,
        "background": nord[3],
        "foreground": palette["fg"],
        "charge_char": "\ue63c ",
        "discharge_char": "\ue3e6 ",
        "empty_char": "\uf244 ",
        "full_char": "\uf240 ",
        "unknown_char": "\ue645 ",
        "format": "{char} {percent:2.0%}",
        # "low_background": palette["yellow"],
        "low_foreground": palette["yellow"],
        "low_percentage": 0.30,
        "show_short_text": False,
    },
]

datetime = [
    widget.Clock,
    {
        **fontinfo,
        "background": nord[7],
        "foreground": palette["bg"],
        "format": "\ue8df %a, %b %e, %T  ",
    },
]


def widgetlist():
    isLaptop = exists("/sys/class/power_supply/BAT0")
    laptopWidgets = [batt] if isLaptop else []
    return (
        [
            spacer_small,
            logo,
            groupbox,
            layout,
            windowname,
            cpu,
            mem,
        ]
        + laptopWidgets
        + [
            systray,
            datetime,
        ]
    )


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

            end_sep["foreground"] = widgetlist[index + 1][1].get(
                "background", palette["bg"]
            )
            end_sep["background"] = wid[1].get("background", palette["bg"])

            if wid[1].get("is_spacer") and wid[1].get("inheirit"):
                bg = widgetlist[index + 1][1].get("background", palette["bg"])
                wid[1]["background"] = bg
                end_sep["background"] = bg

            # insert separator before current
            if wid[1].get("use_separator", True):
                styled.insert(styled.index(wid) + 1, (widget.TextBox, end_sep))

    return [w[0](**w[1]) for w in styled]


def my_bar():
    return bar.Bar(
        [*style(widgetlist())],
        32,
        foreground=palette["fg"],
        background=palette["bg"],
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
