require("hyprland.lib")
require("hyprland.variables")
if is_file_exists(HOME .. "/.config/hypr/custom/variables.lua") then
	require("custom.variables")
end

local qsScripts = "$HOME/.config/quickshell/$qsConfig/scripts"
local hyprScripts = "$HOME/.config/hypr/hyprland/scripts"
local qsIpcCall = "qs -c $qsConfig ipc call"
local qsIsAlive = qsIpcCall .. " TEST_ALIVE"

-- quickshell
hl.bind("SUPER + SPACE", hl.dsp.global("quickshell:searchToggleRelease"), { description = "Shell: Toggle search" })
hl.bind("SUPER + SPACE", hl.dsp.exec_cmd(qsIsAlive .. " || pkill fuzzel || fuzzel"))

--TODO what???? hl.bind("SUPER", hl.dsp.global("quickshell:workspaceNumber"), { ignore_mods = true, transparent = true })
hl.bind("SUPER + Tab", hl.dsp.global("quickshell:overviewWorkspacesToggle"), { description = "Shell: Toggle overview" })
hl.bind("SUPER + V", hl.dsp.global("quickshell:overviewClipboardToggle"))
hl.bind("SUPER + Period", hl.dsp.global("quickshell:overviewEmojiToggle"))
--hl.bind("SUPER + A", hl.dsp.global("quickshell:sidebarLeftToggle"), { description = "Shell: Toggle left sidebar" })
--hl.bind("SUPER + SHIFT + A", hl.dsp.global("quickshell:sidebarLeftToggleDetach"))
--hl.bind("SUPER + B", hl.dsp.global("quickshell:sidebarLeftToggle"))
--hl.bind("SUPER + O", hl.dsp.global("quickshell:sidebarLeftToggle"))
hl.bind("SUPER + C", hl.dsp.global("quickshell:sidebarRightToggle"), { description = "Shell: Toggle right sidebar" })
hl.bind("SUPER + Slash", hl.dsp.global("quickshell:cheatsheetToggle"), { description = "Shell: Toggle cheatsheet" })
--hl.bind("SUPER + K", hl.dsp.global("quickshell:oskToggle"), { description = "Shell: Toggle on-screen keyboard" })
--hl.bind("SUPER + M", hl.dsp.global("quickshell:mediaControlsToggle"), { description = "Shell: Toggle media controls" })
hl.bind("SUPER + G", hl.dsp.global("quickshell:overlayToggle"), { description = "Shell: Toggle widget overlay" })
hl.bind("CTRL + ALT + Delete", hl.dsp.global("quickshell:sessionToggle"), { description = "Shell: Toggle session menu" })
hl.bind("SUPER + ESCAPE", hl.dsp.global("quickshell:sessionToggle"))
hl.bind("SUPER + SHIFT + G", hl.dsp.global("quickshell:barToggle"), { description = "Shell: Toggle bar" })
hl.bind("CTRL + ALT + Delete", hl.dsp.exec_cmd(qsIsAlive .. " || pkill wlogout || wlogout -p layer-shell"))
hl.bind("SUPER + ESCAPE", hl.dsp.exec_cmd(qsIsAlive .. " || pkill wlogout || wlogout -p layer-shell"))
hl.bind("SHIFT + SUPER + ALT + Slash", hl.dsp.exec_cmd("qs -p $HOME/.config/quickshell/$qsConfig/welcome.qml"))

-- wallpaper
hl.bind("CTRL + SUPER + T", hl.dsp.global("quickshell:wallpaperSelectorToggle"),
    { description = "Shell: Change wallpaper" }) --TODO set default wallpaper dir
hl.bind("CTRL + SUPER + ALT + T", hl.dsp.global("quickshell:wallpaperSelectorRandom"),
    { description = "Shell: Random wallpaper" })
hl.bind("CTRL + SUPER + SHIFT + D", hl.dsp.global("quickshell:toggleLightDark"),
    { description = "Shell: Toggle light/dark mode" })
hl.bind("CTRL + SUPER + T", hl.dsp.exec_cmd(qsIsAlive .. " || " .. qsScripts .. "/colors/switchwall.sh"))
hl.bind("CTRL + SUPER + R", hl.dsp.exec_cmd("killall ydotool qs quickshell; qs -c $qsConfig &"),
    { description = "Shell: Restart widgets" })
--hl.bind("CTRL + SUPER + P", hl.dsp.global("quickshell:panelFamilyCycle"), { description = "Shell: Cycle panel family" })


-- launch apps
hl.bind("SUPER + H", hl.dsp.exec_cmd("kitty"))
hl.bind("SUPER + B", hl.dsp.exec_cmd("firefox"))
hl.bind("SUPER + F", hl.dsp.exec_cmd("nautilus --new-window"))
hl.bind("SUPER", hl.dsp.exec_cmd("pkill wofi || wofi --show drun"))
hl.bind("SUPER + L", hl.dsp.global("quickshell:lock"))

-- quit apps
hl.bind("SUPER + Q", hl.dsp.window.close("activewindow"))
hl.bind("SUPER + SHIFT + Q", hl.dsp.window.kill("activewindow"))
hl.bind("ALT + F4", hl.dsp.window.close("activewindow"))
--TODO: implement killing program that owns window

-- window manipulation
hl.bind("SUPER + M", hl.dsp.window.fullscreen({mode = "maximized", action = "toggle"}))
hl.bind("SUPER + SHIFT + M", hl.dsp.window.fullscreen({mode = "fullscreen", action = "toggle"}))

hl.bind("ALT + TAB", hl.dsp.window.cycle_next())
hl.bind("ALT + TAB", hl.dsp.window.alter_zorder({mode = "top"}))
hl.bind("ALT + SHIFT + TAB", hl.dsp.window.cycle_next({next = "prev"}))
hl.bind("ALT + SHIFT + TAB", hl.dsp.window.alter_zorder({mode = "top"}))
hl.bind("SUPER + TAB", hl.dsp.exec_cmd("qs ipc -c overview call overview toggle"))

--TODO: use plugin for workspace overview
local floating = false
function float_all()
	for _,window in pairs(hl.get_windows()) do
		if not floating then
			hl.dsp.window.float({action = "set", window = window})
		else
			hl.dsp.window.float({action = "unset", window = window})
		end
	end
	floating = not floating
end
hl.bind("SUPER + HOME", hl.dsp.window.float())
hl.bind("SUPER + SHIFT + H", float_all) --TODO: fix this, it does nothing

hl.bind("SUPER + A", hl.dsp.layout("togglesplit"))
hl.bind("SUPER + SHIFT + A", hl.dsp.layout("swapsplit"))

hl.bind("SUPER + S", hl.dsp.focus({direction = "left"}))
hl.bind("SUPER + O", hl.dsp.focus({direction = "right"}))
hl.bind("SUPER + T", hl.dsp.focus({direction = "up"}))
hl.bind("SUPER + N", hl.dsp.focus({direction = "down"}))

hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), {mouse = true})
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), {mouse = true})

hl.bind("SUPER + right", hl.dsp.window.resize({x = 100, y = 0, relative = true}))
hl.bind("SUPER + left", hl.dsp.window.resize({x = -100, y = 0, relative = true}))
hl.bind("SUPER + down", hl.dsp.window.resize({x = 0, y = 100, relative = true}))
hl.bind("SUPER + up", hl.dsp.window.resize({x = 0, y = -100, relative = true}))

hl.bind("SUPER + SHIFT + S", hl.dsp.window.swap({direction = "left"}))
hl.bind("SUPER + SHIFT + O", hl.dsp.window.swap({direction = "right"}))
hl.bind("SUPER + SHIFT + T", hl.dsp.window.swap({direction = "up"}))
hl.bind("SUPER + SHIFT + N", hl.dsp.window.swap({direction = "down"}))

-- Utilities
hl.bind("SUPER + V", hl.dsp.exec_cmd(
        qsIsAlive .. " || pkill fuzzel || cliphist list | fuzzel --match-mode fzf --dmenu | cliphist decode | wl-copy"),
    { description = "Utilities: Clipboard history >> clipboard" })
hl.bind("SUPER + Period", hl.dsp.exec_cmd(
        qsIsAlive .. " || pkill fuzzel || " .. hyprScripts .. "/fuzzel-emoji.sh copy"),
    { description = "Utilities: Emoji >> clipboard" })
hl.bind("SUPER + SHIFT + D", hl.dsp.global("quickshell:regionScreenshot"), { description = "Utilities: Screen snip" })
hl.bind("SUPER + SHIFT + D",
    hl.dsp.exec_cmd(qsIsAlive .. " || pidof slurp || hyprshot --freeze --mode region --silent"))
hl.bind("SUPER + D", hl.dsp.global("quickshell:regionScreenshot"), { description = "Utilities: Screen snip" })
hl.bind("SUPER + D",
    hl.dsp.exec_cmd(qsIsAlive .. " || pidof slurp || hyprshot --freeze --clipboard-only --mode region --silent"))
hl.bind("SUPER + SHIFT + 0", hl.dsp.global("quickshell:regionSearch"), { description = "Utilities: Google Lens" })
hl.bind("SUPER + SHIFT + 0", hl.dsp.exec_cmd(qsIsAlive .. " || pidof slurp || " .. hyprScripts .. "/snip_to_search.sh"))
-- OCR
hl.bind("SUPER + SHIFT + X", hl.dsp.global("quickshell:regionOcr"),
    { description = "Utilities: Character recognition >> clipboard" })
hl.bind("SUPER + SHIFT + 9", hl.dsp.global("quickshell:screenTranslate"),
    { description = "Utilities: Translate screen content" })
hl.bind("SUPER + SHIFT + X", hl.dsp.exec_cmd(
    qsIsAlive ..
    " || pidof slurp || grim -g \"$(slurp $SLURP_ARGS)\" \"/tmp/ocr_image.png\" && tesseract \"/tmp/ocr_image.png\" stdout -l $(tesseract --list-langs | awk 'NR>1{print $1}' | tr '\\\\n' '+' | sed 's/\\\\+$/\\\\n/') | wl-copy && rm \"/tmp/ocr_image.png\""
))

-- Color picker
hl.bind("SUPER + X", hl.dsp.exec_cmd("hyprpicker -a"),
    { description = "Utilities: Pick color #RRGGBB >> clipboard" })

-- Recording stuff
hl.bind("SUPER + SHIFT + BRACKETRIGHT", hl.dsp.global("quickshell:regionRecord"),
    { locked = true, description = "Utilities: Record region (no sound)" })
hl.bind("SUPER + SHIFT + BRACKETRIGHT", hl.dsp.exec_cmd(qsIsAlive .. " || " .. qsScripts .. "/videos/record.sh"), { locked = true })
hl.bind("SUPER + ALT + BRACKETRIGHT", hl.dsp.global("quickshell:regionRecord"), { locked = true })
hl.bind("SUPER + ALT + BRACKETRIGHT", hl.dsp.exec_cmd(qsIsAlive .. " || " .. qsScripts .. "/videos/record.sh"), { locked = true })
hl.bind("CTRL + ALT + BRACKETRIGHT", hl.dsp.exec_cmd(qsScripts .. "/videos/record.sh --fullscreen"), { locked = true })
hl.bind("SUPER + SHIFT + ALT + BRACKETRIGHT", hl.dsp.exec_cmd(qsScripts .. "/videos/record.sh --fullscreen --sound"),
    { locked = true, description = "Utilities: Record screen (with sound)" })

-- Fullscreen screenshot
local grimhyprctl = "grim -o \"$(hyprctl activeworkspace -j | jq -r '.monitor')\""
hl.bind("Print", hl.dsp.exec_cmd(grimhyprctl .. " - | wl-copy"),
    { locked = true, description = "Utilities: Screenshot >> clipboard" })
hl.bind("CTRL + Print", hl.dsp.exec_cmd(
    "mkdir -p $(xdg-user-dir PICTURES)/Screenshots && " ..
    grimhyprctl .. " $(xdg-user-dir PICTURES)/Screenshots/Screenshot_\"$(date '+%Y-%m-%d_%H.%M.%S')\".png"
), { locked = true, non_consuming = true, description = "Utilities: Screenshot >> clipboard & file" })
hl.bind("CTRL + Print", hl.dsp.exec_cmd(grimhyprctl .. " - | wl-copy"), { locked = true, non_consuming = true })

--[[hl.bind("SUPER + X", hl.dsp.exec_cmd("hyprpicker -a -q"))
hl.bind("SUPER + D", hl.dsp.exec_cmd("hyprshot -m region -s -z --clipboard-only"))
hl.bind("SUPER + SHIFT + D", hl.dsp.exec_cmd("hyprshot -m region -z -o /home/aliign/Pictures/Screenshots"))
hl.bind("SUPER + V", hl.dsp.exec_cmd("cliphist list | rofi -dmenu | cliphist decode | wl-copy")) --TODO: find some quickshell alternative or something
--TODO: implement screenshot cliphist
hl.bind("SUPER + J", hl.dsp.exec_cmd("hyprshade toggle /home/aliign/.config/hypr/hyprshade/grayscale"))
]]--

-- workspaces
hl.bind("SUPER + ALT + R", hl.dsp.focus({workspace = "r+1"}), {repeating = true})
hl.bind("SUPER + ALT + Q", hl.dsp.focus({workspace = "r-1"}), {repeating = true})
hl.bind("SUPER + ALT + 3", hl.dsp.window.move({workspace = "r+1", follow = true}), {repeating = true})
hl.bind("SUPER + ALT + 1", hl.dsp.window.move({workspace = "r-1", follow = true}), {repeating = true})

-- function keys
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -q s +10%"), {repeating = true})
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -q s 10%-"), {repeating = true})
hl.bind("SHIFT + XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -q s +1%"), {repeating = true})
hl.bind("SHIFT + XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -q s 1%-"), {repeating = true})

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ +5%"), {repeating = true})
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ -5%"), {repeating = true})
hl.bind("SHIFT + XF86AudioRaiseVolume", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ +1%"), {repeating = true})
hl.bind("SHIFT + XF86AudioLowerVolume", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ -1%"), {repeating = true})

hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl pause"))
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("pactl set-source-mute @DEFAULT_SROUCE@ toggle"))

hl.bind("XF86DisplayToggle", function()
	local mons = hl.get_monitors()

	local names = {}
	for i, v in ipairs(mons) do
		if i <= 2 then
			names["monitor" .. i] = v.name
		end
	end
	local str = ""

	for k, v in pairs(names) do
		str = str .. " " .. k .. ": " .. v .. ", "
	end

	hl.dispatch(hl.dsp.workspace.swap_monitors(names))
end)
