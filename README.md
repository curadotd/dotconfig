# dotconfig

My dot config files — themed as **macOS Tahoe / liquid glass** (graphite `#141417`, Tahoe blue `#6CB6FF`, translucent blurred surfaces, rounded corners).

## Layout

| Path | What it is |
|------|------------|
| `hypr/` | Hyprland (main desktop): `hyprland.conf` + `imports/` (theme, animations, keybindings, window rules, monitors, nvidia), `hyprlock`, `hypridle`, `hyprpaper`, helper `scripts/` |
| `waybar/` | Glass top bar + `scripts/` (cpu_info, gpu_info, amdgpu.py, powermenu) |
| `rofi/` | Launcher/clipboard/powermenu, `themes/macTahoe.rasi` is the main theme |
| `dunst/` | Notifications (glass, `dunstrc`) |
| `kitty/` | Terminal, SF Mono + Tahoe dark palette |
| `picom/` | X11 compositor config for the DWM fallback (blur, rounding, animations — FT-Labs fork) |
| `qt5ct/` | Qt theming (kvantum + MacTahoe icons) |
| `starship.toml` | Tahoe-styled prompt |
| `bashrc`, `MangoHud/`, `nwg-look/`, `gamemode.ini`, `user-dirs.*` | Shell and misc |

## Requirements

Installed by the companion [linux_workstation_build](https://github.com/curadotd/linux_workstation_build) scripts (`install_hyprland` / `install_dwm`, `install_mactahoe_theme`, `install_fonts`):

- **Hyprland session:** hyprland, hyprpaper, hyprlock, hypridle, hyprshot, hyprlauncher, hyprpolkitagent, hyprshutdown, waybar, rofi, dunst, kitty, cliphist, wl-clipboard, pamixer, playerctl, jq, pavucontrol, blueman, dolphin
- **DWM session:** dwm-curado, slstatus-curado, picom (FT-Labs fork), feh, flameshot, rofi, dunst, kitty
- **Theme/fonts:** MacTahoe GTK + icon themes (nord dark variants), SF Pro / SF Mono (apple-fonts, with Inter and FiraCode Nerd Font as fallbacks)

## Notes

- Monitor names (`DP-5`) and wallpaper paths (`/mnt/repository/desktops/`) are machine-specific — adjust `hypr/imports/monitors.conf`, `hypr/hyprpaper.conf` and `hypr/hyprlock.conf`.
- Gamemode toggle (`SUPER+ALT+G`) flips off blur/shadows/animations for performance.
