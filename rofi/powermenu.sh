#!/usr/bin/env bash

# Power menu for Hyprland and DWM sessions

# CMDs
uptime="$(uptime -p | sed -e 's/up //g')"

# Options (Nerd Font glyphs)
shutdown='󰐥'
reboot='󰜉'
lock='󰌾'
suspend='󰤄'
logout='󰍃'

# Rofi CMD
rofi_cmd() {
	rofi -dmenu \
		-p "" \
		-mesg "Uptime: $uptime" \
		-theme "$HOME/.config/rofi/themes/powermenu.rasi"
}

# Pass variables to rofi dmenu
run_rofi() {
	echo -e "$lock\n$suspend\n$logout\n$reboot\n$shutdown" | rofi_cmd
}

# Execute Command
run_cmd() {
	case $1 in
		--shutdown)
			systemctl poweroff
			;;
		--reboot)
			systemctl reboot
			;;
		--suspend)
			playerctl -a pause 2>/dev/null
			systemctl suspend
			;;
		--logout)
			if [ -n "$HYPRLAND_INSTANCE_SIGNATURE" ]; then
				hyprctl dispatch exit
			else
				case "$DESKTOP_SESSION" in
					dwm)
						pkill dwm
						;;
					plasma)
						qdbus org.kde.ksmserver /KSMServer logout 0 0 0
						;;
					*)
						loginctl terminate-session "$XDG_SESSION_ID"
						;;
				esac
			fi
			;;
	esac
}

# Actions
chosen="$(run_rofi)"
case "${chosen}" in
    "${shutdown}")
		run_cmd --shutdown
        ;;
    "${reboot}")
		run_cmd --reboot
        ;;
    "${lock}")
		if [ -n "$HYPRLAND_INSTANCE_SIGNATURE" ]; then
			hyprlock
		elif command -v i3lock >/dev/null 2>&1; then
			i3lock -c 141417
		fi
        ;;
    "${suspend}")
		run_cmd --suspend
        ;;
    "${logout}")
		run_cmd --logout
        ;;
esac
