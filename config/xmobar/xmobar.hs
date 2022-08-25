#!/usr/bin/env nix-shell
#!nix-shell --keep LANG -i runghc -p "haskellPackages.ghcWithPackages (pkgs: [pkgs.xmobar])"

import           Control.Concurrent             ( forkOS )
import           Data.Foldable                  ( find )
import qualified Data.Text                     as T
import           System.Directory               ( doesPathExist )
import           System.Process                 ( readProcess
                                                , readProcessWithExitCode
                                                )
import           Text.Read                      ( readMaybe )
import           Xmobar

main :: IO ()
main = do
  isLaptop <- doesPathExist "/sys/class/power_supply/BAT0" -- heuristic for detecting laptops
  forkOS $ xmobar $ topBar isLaptop
  xmobar $ bottomBar isLaptop

topBar :: Bool -> Config
topBar isLaptop = baseConfig { template = left ++ "}" ++ middle ++ "{" ++ right
                             , position = TopSize L 100 30
                             }
 where
  left   = "%XMonadLog% "
  middle = " %time% "
  right | isLaptop  = "%ibus%  %volume%  %date%  %battery% "
        | otherwise = "%ibus%  %volume%  %date% "

bottomBar :: Bool -> Config
bottomBar isLaptop = baseConfig
  { template = left ++ "}" ++ middle ++ "{" ++ right
  , position = Bottom
  }
 where
  left   = ""
  middle = ""
  right  = " %multicpu%  %memory%  %wifi% "

baseConfig :: Config
baseConfig = defaultConfig
  { font             = "xft:JetBrainsMono Nerd Font:size=12:antialias=true"
  , additionalFonts  = [ "xft:Font Awesome 6 Free Solid:pixelsize=12"
                       , "xft:Font Awesome 6 Brands:pixelsize=12"
                       ]
  , bgColor          = "#2e3440"
  , fgColor          = "#ece9f0"
  , position         = Top
  , sepChar          = "%"   -- delineator between plugin names and straight text
  , alignSep         = "}{"  -- separator between left-right alignment
  , lowerOnStart     = True   -- send to bottom of window stack on start
  , hideOnStart      = False  -- start with window unmapped (hidden)
  , allDesktops      = True   -- show on all desktops
  , overrideRedirect = True   -- set the Override Redirect flag (Xlib)
  , pickBroadest     = False  -- choose widest display (multi-monitor)
  , persistent       = False  -- enable/disable hiding (True = disabled)
  , commands         = runnables
  }

runnables :: [Runnable]
runnables =
  [ cpuRunnable
  , memoryRunnable
  , batteryRunnable
  , wirelessRunnable
  , volumeRunnable
  , dateRunnable
  , timeRunnable
  , ibusRunnable
  , Run XMonadLog
  ]

cpuRunnable :: Runnable
cpuRunnable = Run $ MultiCpu
  [ "--template"
  , "<fn=1>\xf2db</fn> <total>%"
  , "--Low"
  , "50"         -- units: %
  , "--High"
  , "85"         -- units: %
  , "--low"
  , "#a3be8c"
  , "--normal"
  , "#ebcb8b"
  , "--high"
  , "#bf616a"
  ]
  10

memoryRunnable :: Runnable
memoryRunnable = Run $ Memory
  [ "--template"
  , "<fn=1>\xf538</fn> <usedratio>%"
  , "--Low"
  , "20"        -- units: %
  , "--High"
  , "90"        -- units: %
  , "--low"
  , "#a3be8c"
  , "--normal"
  , "#ebcb8b"
  , "--high"
  , "#bf616a"
  ]
  10

wirelessRunnable :: Runnable
wirelessRunnable = Run $ Wifi "<fn=1>\xf1eb</fn> " "wifi" 10

batteryRunnable :: Runnable
batteryRunnable = Run $ Battery
  [ "--template"
  , "<fn=1>\xf241</fn> <acstatus>"
  , "--Low"
  , "10"        -- units: %
  , "--High"
  , "80"        -- units: %
  , "--low"
  , "#bf616a"
  , "--normal"
  , "#ebcb8b"
  , "--high"
  , "#a3be8c"
  , "--" -- battery specific options
                             -- discharging status
  , "-o"
  , "<left>% (<timeleft>)"
                             -- AC "on" status
  , "-O"
  , "<fc=#ebcb8b>Charging</fc>"
                             -- charged status
  , "-i"
  , "<fc=#a3be8c>Charged</fc>"
  ]
  50

-- volumeRunnable :: Runnable
-- volumeRunnable = Run $ Volume
--   "default"
--   "Master"
--   [ "--template"
--   , "<fn=1>\xf028</fn> <volume>% <status>"
--   , "--"
--   , "--on"
--   , "[on]"
--   , "--off"
--   , "[off]"
--   , "--onc"
--   , "#a3be8c"
--   , "--offc"
--   , "#bf616a"
--   ]
--   10
volumeRunnable :: Runnable
volumeRunnable = Run $ MyVolume "<fn=1>\xf028</fn> " "volume" 5

dateRunnable :: Runnable
dateRunnable = Run $ Date "<fn=1>\xf073</fn> %a-%b %-d" "date" 10

timeRunnable :: Runnable
timeRunnable = Run $ Date "<fn=1>\xf017</fn> %T" "time" 10

ibusRunnable :: Runnable
ibusRunnable = Run $ IBus
  [("en", "<fn=1>\xf11c</fn> en"), ("cn", "<fn=1>\xf11c</fn> cn")]
  "ibus"
  5

{- ===== Plugins =====  -}
-- Need my own volume plugin because the built-in one somehow crashes on first start
data MyVolume = MyVolume String String Int
  deriving (Read, Show)

instance Exec MyVolume where
  alias (MyVolume _ a _) = a
  start (MyVolume prefix _ r) = myVolume prefix r

myVolume :: String -> Int -> (String -> IO ()) -> IO ()
myVolume prefix r callback = go
 where
  formatVolume volume | volume == 0 = "<fc=#ebcb8b>" ++ show volume ++ "</fc>%"
                      | otherwise   = "<fc=#a3be8c>" ++ show volume ++ "</fc>%"
  format volumeS isMuteS = case isMuteS of
    "true"  -> "<fc=#bf616a>off</fc>"
    "false" -> maybe "???" formatVolume (readMaybe volumeS)
    _       -> "???"
  go = do
    (_, volumeS, _) <- readProcessWithExitCode "pamixer" ["--get-volume"] []
    (_, isMuteS, _) <- readProcessWithExitCode "pamixer" ["--get-mute"] []
    let final = prefix ++ format (strip volumeS) (strip isMuteS)
    callback final
    tenthSeconds r
    go


-- Plugin to show wifi name
data Wifi = Wifi String String Int
  deriving (Read, Show)

instance Exec Wifi where
  alias (Wifi _ a _) = a
  start (Wifi prefix _ r) = wifi prefix r

wifi :: String -> Int -> (String -> IO ()) -> IO ()
wifi prefix r callback = go
 where
  go = do
    (_, tableS, _) <- readProcessWithExitCode
      "nmcli"
      ["--fields", "device,type,state,connection", "dev", "status"]
      []
    let rows = map words . tail . lines . strip $ tableS
        target =
          find (\r -> (r !! 1 == "wifi") && (r !! 2 == "connected")) rows
        final = prefix ++ maybe "N/A" (!! 3) target
    callback final
    tenthSeconds r
    go

-- Plugin to show IBus engine
data IBus = IBus [(String, String)] String Int
  deriving (Read, Show)

instance Exec IBus where
  alias (IBus _ a _) = "ibus"
  start (IBus fs _ r) = ibus fs r

ibus :: [(String, String)] -> Int -> (String -> IO ()) -> IO ()
ibus fs r callback = go
 where
  formatEngine engine = case engine of
    "xkb:us::eng" -> "en"
    "libpinyin"   -> "cn"
    _             -> engine
  formatOutput pre = case find (\f -> fst f == pre) fs of
    Just (f, s) -> s
    Nothing     -> pre
  go = do
    engine <- readProcess "ibus" ["engine"] []
    callback . formatOutput . formatEngine . strip $ engine
    tenthSeconds r
    go

-- Helper functions
strip :: String -> String
strip = T.unpack . T.strip . T.pack
