--
-- xmonad example config file.
--
-- A template showing all available configuration hooks,
-- and how to override the defaults in your own xmonad.hs conf file.
--
-- Normally, you'd only override those defaults you care about.
--

import           Data.Monoid
import           System.Exit
import           XMonad
-- import           XMonad.Actions.Navigation2D
import           XMonad.Actions.Volume
import           XMonad.Hooks.DynamicLog
import           XMonad.Hooks.EwmhDesktops
import           XMonad.Hooks.ManageDocks
import           XMonad.Hooks.ManageHelpers
import           XMonad.Hooks.StatusBar
import           XMonad.Hooks.StatusBar.PP
import           XMonad.Layout.Spacing
import           XMonad.Layout.Grid
import           XMonad.Layout.ThreeColumns
import           XMonad.Layout.MultiColumns
import           XMonad.Util.Dmenu             as DM
import           XMonad.Util.EZConfig
import           XMonad.Util.Loggers
import           XMonad.Util.Run

import qualified Data.Map                      as M
import qualified XMonad.StackSet               as W

-- Nord colors
-- https://www.nordtheme.com/docs/colors-and-palettes
nord0 = "#2e3440"
nord1 = "#3b4252"
nord2 = "#434c5e"
nord3 = "#4c566a"
nord4 = "#d8dee9"
nord5 = "#e5e9f0"
nord6 = "#eceff4"
nord7 = "#8fbcbb"
nord8 = "#88c0d0"
nord9 = "#81a1c1"
nord10 = "#5e81ac"
nord11 = "#bf616a"
nord12 = "#d08770"
nord13 = "#ebcb8b"
nord14 = "#a3be8c"
nord15 = "#b48ead"

myEmacs :: String
myEmacs = "emacsclient -c"

myEmacsEval :: String -> String
myEmacsEval s = myEmacs ++ " -e '" ++ s ++ "'"

myConfig =
  def { modMask            = mod4Mask -- <Super> key
      , terminal           = "kitty"
      , borderWidth        = 3
      , normalBorderColor  = nord1
      , focusedBorderColor = nord8
      , workspaces         = myWorkspaces
      , startupHook        = myStartupHook
      , layoutHook         = spacingWithEdge 10 $ myLayoutHook
      , manageHook         = myManageHook
      , logHook            = myLogHook
      , handleEventHook    = myEventHook
      }
    `additionalKeysP` myKeys

main :: IO ()
main =
  xmonad
    $ docks
    . ewmh
    . withSB (statusBarProp "xmobar" (pure myXmobarPP))
    -- . withNavigation2DConfig def
    $ myConfig

-- App launcher: using rofi over dmenu
-- myAppLauncher =
--   "rofi -show combi -combi-modi \"window,drun\" -modi \"combi,run,ssh\" -show-icons"

myDmenuArgs :: [String]
myDmenuArgs = ["-dmenu", "-i", "-show-icons"]

myDmenu :: MonadIO m => [String] -> m String
myDmenu = DM.menuArgs "rofi" myDmenuArgs

myDmenuMap :: MonadIO m => M.Map String a -> m (Maybe a)
myDmenuMap = DM.menuMapArgs "rofi" myDmenuArgs

myXmobarPP :: PP
myXmobarPP = def { ppSep             = nord7' " • "
                 , ppTitle           = shorten 40
                 -- , ppTitleSanitize   = xmobarStrip
                 -- , ppCurrent = wrap " " "" . xmobarBorder "Top" nord7 2
                 -- , ppCurrent = wrap " " "" . xmobarBorder "Bottom" nord8 2
                 , ppCurrent = wrap " " "" . xmobarBorder "Top" nord8 2
                 -- , ppHidden          = nord6' . wrap " " ""
                 -- , ppHidden          = wrap " " "" . xmobarBorder "Top" nord9 2
                 , ppHidden          = wrap " " ""
                 -- , ppHiddenNoWindows = nord5' . wrap " " ""
                 , ppHiddenNoWindows = nord3' . wrap " " ""
                 , ppUrgent          = nord11' . wrap (nord13' "!") (nord13' "!")
                 , ppOrder           = \(ws:l:t:_) -> [ws, l, t]
                 -- , ppExtras          = [logTitles formatFocused formatUnfocused]
                 }
 where
  -- formatFocused   = wrap (nord5' "[") (nord5' "]") . nord8' . ppWindow
  -- formatUnfocused = wrap (nord5' "[") (nord5' "]") . nord9' . ppWindow

  -- | Windows should have *some* title, which should not not exceed a
  -- sane length.
  ppWindow :: String -> String
  ppWindow = xmobarRaw . (\w -> if null w then "untitled" else w) . shorten 30

  nord5', nord6', nord7', nord9', nord11', nord13' :: String -> String
  nord3'    = xmobarColor nord3 ""
  nord5'    = xmobarColor nord5 ""
  nord6'    = xmobarColor nord6 ""
  nord7'    = xmobarColor nord7 ""
  nord8'  = xmobarColor nord8 ""
  nord9'  = xmobarColor nord9 ""
  nord10'  = xmobarColor nord10 ""
  nord11'  = xmobarColor nord11 ""
  nord13'  = xmobarColor nord13 ""

-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- A tagging example:
--
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
--
myWorkspaces :: [String]
myWorkspaces = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]


------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys :: [(String, X ())]
myKeys =
  -- Xmonad
  [ ("M-C-r"                 , spawn "xmonad --recompile")
  , ("M-S-r"                 , spawn "xmonad --restart")
  , ("M-S-q"                 , io exitSuccess)

  -- Window kill
  , ("M-S-c"                 , kill)
  -- , ("M-S-a"                 , killAll)

  -- Window navigation
  , ("M-m"                   , windows W.focusMaster)
  , ("M-p", spawn "rofi -show drun -show-icons")
  , ("M-S-p"                 , spawn "rofi -show run")
  -- , ("M-h"                   , windowGo L False)
  -- , ("M-j"                   , windowGo D False)
  -- , ("M-k"                   , windowGo U False)
  -- , ("M-l"                   , windowGo R False)

  -- Favorite programs
  , ("M-<Return>"            , spawn "kitty")
  , ("M-b", spawn "qutebrowser")

  -- Emacs (SUPER-e followed by a key)
  , ("M-e a", spawn $ myEmacsEval "(org-todo-list)")
  , ("M-e b", spawn $ myEmacsEval "(ibuffer)")
  , ("M-e d", spawn $ myEmacsEval "(dired nil)")
  , ("M-e e", spawn myEmacs)
  , ("M-e t", spawn $ myEmacsEval "(org-roam-dailies-capture-today)")
  , ("M-e v", spawn $ myEmacsEval "(+vterm/here nil)")

  -- Multimedia keys
  --, ("<XF86AudioMute>", spawn "amixer set Master toggle")
  --, ("<XF86AudioLowerVolume>", spawn "amixer set Master 5%- unmute")
  --, ("<XF86AudioRaiseVolume>", spawn "amixer set Master 5%+ unmute")
  , ("<XF86AudioMute>"       , toggleMute >> return ())
  , ("<XF86AudioLowerVolume>", lowerVolume 5 >> return ())
  , ("<XF86AudioRaiseVolume>", raiseVolume 5 >> return ())
  ]
--myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    ---- launch a terminal
    --[ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)

    ---- launch dmenu
    --, ((modm,               xK_p     ), spawn myAppLauncher)

    ---- launch gmrun
    --, ((modm .|. shiftMask, xK_p     ), spawn "gmrun")

    ---- close focused window
    --, ((modm .|. shiftMask, xK_c     ), kill)

     ---- Rotate through the available layout algorithms
    --, ((modm,               xK_space ), sendMessage NextLayout)

    ----  Reset the layouts on the current workspace to default
    --, ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    ---- Resize viewed windows to the correct size
    --, ((modm,               xK_n     ), refresh)

    ---- Move focus to the next window
    --, ((modm,               xK_Tab   ), windows W.focusDown)

    ---- Move focus to the next window
    --, ((modm,               xK_j     ), windows W.focusDown)

    ---- Move focus to the previous window
    --, ((modm,               xK_k     ), windows W.focusUp  )

    ---- Move focus to the master window
    --, ((modm,               xK_m     ), windows W.focusMaster  )

    ---- Swap the focused window and the master window
    --, ((modm,               xK_Return), windows W.swapMaster)

    ---- Swap the focused window with the next window
    --, ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )

    ---- Swap the focused window with the previous window
    --, ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )

    ---- Shrink the master area
    --, ((modm,               xK_h     ), sendMessage Shrink)

    ---- Expand the master area
    --, ((modm,               xK_l     ), sendMessage Expand)

    ---- Push window back into tiling
    --, ((modm,               xK_t     ), withFocused $ windows . W.sink)

    ---- Increment the number of windows in the master area
    --, ((modm              , xK_comma ), sendMessage (IncMasterN 1))

    ---- Deincrement the number of windows in the master area
    --, ((modm              , xK_period), sendMessage (IncMasterN (-1)))

    ---- Toggle the status bar gap
    ---- Use this binding with avoidStruts from Hooks.ManageDocks.
    ---- See also the statusBar function from Hooks.DynamicLog.
    ----
    ---- , ((modm              , xK_b     ), sendMessage ToggleStruts)

    ---- Quit xmonad
    --, ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))

    ---- Restart xmonad
    --, ((modm              , xK_q     ), spawn "xmonad --recompile; xmonad --restart")

    ---- Run xmessage with a summary of the default keybindings (useful for beginners)
    --, ((modm .|. shiftMask, xK_slash ), spawn ("echo \"" ++ help ++ "\" | xmessage -file -"))
    --]
    -- ++

    ----
    ---- mod-[1..9], Switch to workspace N
    ---- mod-shift-[1..9], Move client to workspace N
    ----
    --[((m .|. modm, k), windows $ f i)
        -- | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        -- , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    -- ++

    ----
    ---- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    ---- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    ----
    --[((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        -- | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        -- , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig { XMonad.modMask = modm }) =
  M.fromList
    $

    -- mod-button1, Set the window to floating mode and move by dragging
      [ ( (modm, button1)
        , (\w -> focus w >> mouseMoveWindow w >> windows W.shiftMaster)
        )

    -- mod-button2, Raise the window to the top of the stack
      , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
      , ( (modm, button3)
        , (\w -> focus w >> mouseResizeWindow w >> windows W.shiftMaster)
        )

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
      ]

------------------------------------------------------------------------
-- Layouts:

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
myLayoutHook = avoidStruts (   Tall nmaster delta ratio
                           ||| ThreeColMid nmaster delta ratio
                           ||| Grid
                           ||| multiCol [1] 1 0.01 (-0.5)
                           ||| Full)
 where
  -- The default number of windows in the master pane
  nmaster = 1

  -- Default proportion of screen occupied by master pane
  ratio   = 1 / 2

  -- Percent of screen to increment by when resizing panes
  delta   = 3 / 100

------------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook = composeAll
  [ className =? "MPlayer" --> doFloat
  , className =? "Gimp" --> doFloat
  , resource =? "desktop_window" --> doIgnore
  , resource =? "kdesktop" --> doIgnore
  ]

------------------------------------------------------------------------
-- Event handling

-- * EwmhDesktops users should change this to ewmhDesktopsEventHook
--
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
myEventHook = mempty

------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
myLogHook = return ()

------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
myStartupHook = return ()

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.
--

-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will
-- use the defaults defined in xmonad/XMonad/Config.hs
--
-- No need to modify this.
--
-- defaults =
--   def {
--       -- simple stuff
--         terminal           = myTerminal
--       , focusFollowsMouse  = myFocusFollowsMouse
--       , clickJustFocuses   = myClickJustFocuses
--       , borderWidth        = myBorderWidth
--       , modMask            = myModMask
--       , workspaces         = myWorkspaces
--       , normalBorderColor  = myNormalBorderColor
--       , focusedBorderColor = myFocusedBorderColor
--
--       -- key bindings
--       , mouseBindings      = myMouseBindings
--
--       -- hooks, layouts
--       , layoutHook         = myLayout
--       , manageHook         = myManageHook
--       , handleEventHook    = myEventHook
--       , logHook            = myLogHook
--       , startupHook        = myStartupHook
--       }
--     `additionalKeysP` myKeys

-- | Finally, a copy of the default bindings in simple textual tabular format.
help :: String
help = unlines
  [ "The default modifier key is 'alt'. Default keybindings:"
  , ""
  , "-- launching and killing programs"
  , "mod-Shift-Enter  Launch xterminal"
  , "mod-p            Launch dmenu"
  , "mod-Shift-p      Launch gmrun"
  , "mod-Shift-c      Close/kill the focused window"
  , "mod-Space        Rotate through the available layout algorithms"
  , "mod-Shift-Space  Reset the layouts on the current workSpace to default"
  , "mod-n            Resize/refresh viewed windows to the correct size"
  , ""
  , "-- move focus up or down the window stack"
  , "mod-Tab        Move focus to the next window"
  , "mod-Shift-Tab  Move focus to the previous window"
  , "mod-j          Move focus to the next window"
  , "mod-k          Move focus to the previous window"
  , "mod-m          Move focus to the master window"
  , ""
  , "-- modifying the window order"
  , "mod-Return   Swap the focused window and the master window"
  , "mod-Shift-j  Swap the focused window with the next window"
  , "mod-Shift-k  Swap the focused window with the previous window"
  , ""
  , "-- resizing the master/slave ratio"
  , "mod-h  Shrink the master area"
  , "mod-l  Expand the master area"
  , ""
  , "-- floating layer support"
  , "mod-t  Push window back into tiling; unfloat and re-tile it"
  , ""
  , "-- increase or decrease number of windows in the master area"
  , "mod-comma  (mod-,)   Increment the number of windows in the master area"
  , "mod-period (mod-.)   Deincrement the number of windows in the master area"
  , ""
  , "-- quit, or restart"
  , "mod-Shift-q  Quit xmonad"
  , "mod-q        Restart xmonad"
  , "mod-[1..9]   Switch to workSpace N"
  , ""
  , "-- Workspaces & screens"
  , "mod-Shift-[1..9]   Move client to workspace N"
  , "mod-{w,e,r}        Switch to physical/Xinerama screens 1, 2, or 3"
  , "mod-Shift-{w,e,r}  Move client to screen 1, 2, or 3"
  , ""
  , "-- Mouse bindings: default actions bound to mouse events"
  , "mod-button1  Set the window to floating mode and move by dragging"
  , "mod-button2  Raise the window to the top of the stack"
  , "mod-button3  Set the window to floating mode and resize by dragging"
  ]
