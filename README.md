<div align="center">
    <img src="https://github.com/swaywm/sway/blob/master/assets/Sway_Logo%2BText_Ver1.svg">
</div>
<div align="center">
Configuration files for my <a href="https://en.wikipedia.org/wiki/Tiling_window_manager">tiling window manager</a> / <a href="https://en.wikipedia.org/wiki/Terminal_emulator">terminal</a> based <a href="https://en.wikipedia.org/wiki/Linux">Linux</a> setup.
</div>
<p></p>
<div align="center">
    	<a href="#about">About</a>
  <span> • </span>
       	<a href="#structure">Structure</a>
  <span> • </span>
	<a href="#keybindings">Keybindings</a>
  <span> • </span>
       	<a href="#usage">Usage</a>
  <span> • </span>
	<a href="#install">Install</a>
  <p></p>
</div>

### About
My [dotfiles](https://wiki.archlinux.org/title/Dotfiles), stored directly in `~/.config` as a git repo. No bare repo, no symlinks. The layout follows the [XDG Base Directory Specification](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html).

This setup is not designed to be used with a [Desktop Environment](https://wiki.archlinux.org/title/Desktop_environment). [Sway](https://github.com/swaywm/sway) (via [swayfx](https://github.com/WillPower3309/swayfx)) provides window management, with [Waybar](https://github.com/Alexays/Waybar) as the status bar and [fuzzel](https://github.com/junegunn/fuzzel) as the launcher.

`nvim/` is a separate repository. See [nvim/README.md](https://github.com/SalmaneKhalili/nvim).

### Structure
The majority of this setup is stored across the following folders:

#### ``.config``
Config for the following programs, most of which are [terminal](https://en.wikipedia.org/wiki/Terminal_emulator) based / [cli](https://en.wikipedia.org/wiki/Command-line_interface) applications:

* [**sway**](sway/): [tiling window manager](https://en.wikipedia.org/wiki/Tiling_window_manager). Config includes keybindings, workspaces, window rules, autostart and output setup. Also contains the wallpaper.
* [**waybar**](waybar/): status bar. Transparent background, rounded floating bar. Modules: workspaces, window mode, clock, weather, volume, uptime, backlight, battery, network, cpu, memory, tray, scratchpad and lock.
* [**fuzzel**](fuzzel/): application launcher.
* [**swaylock**](swaylock/): screen locker.
* [**wlogout**](wlogout/): logout / power off menu.
* [**swappy**](swappy/): screenshot GUI, driven by [grim](https://github.com/emersion/grim) and [slurp](https://github.com/emersion/slurp).
* [**sworkstyle**](sworkstyle/): expands windows with mouse gestures.
* [**fish**](fish/): [shell](https://en.wikipedia.org/wiki/Unix_shell) config, [aliases](https://wiki.archlinux.org/title/Bash#Aliases) and associated [plugins](https://github.com/jorgebucaran/fisher).
* [**envman**](envman/): generates `fish/load.fish`. Machine-specific environment, generated rather than committed.
* [**ghostty**](ghostty/): terminal emulator.
* [**lazygit**](lazygit/): terminal UI for [git](https://git-scm.com/).
* [**pavucontrol.ini**](pavucontrol.ini): PulseAudio volume control defaults.
* [**autostart**](autostart/): desktop entries launched at login.
* [**systemd**](systemd/): user units, currently a daily `plan-notify` timer.
* [**mimeapps.list**](mimeapps.list): specify programs to open various mime types.

### Keybindings
`Mod` is the Super key. The authoritative list is in [`sway/config`](sway/config). The most used:

| Key | Action |
| --- | --- |
| `Mod+d` / `Mod+space` | Launch application (fuzzel) |
| `Mod+Return` | Open a terminal |
| `Mod+Shift+e` | Logout menu (wlogout) |
| `Mod+Shift+backspace` | Lock the screen |
| `Print` | Screenshot a region |
| `Mod+Shift+q` | Kill the focused window |
| `Mod+Shift+r` | Reload sway |
| `Mod+Left/Right/Up/Down` | Move focus |
| `Mod+Shift+Left/Right/Up/Down` | Move the window |
| `Mod+1` ... `Mod+0` | Switch workspace |
| `Mod+Shift+1` ... `Mod+Shift+0` | Move the focused window to a workspace |
| `Mod+backspace` | Toggle split |
| `Mod+t` / `Mod+e` | Tabbed / stacked layout |
| `Mod+Shift+space` | Toggle floating |
| `Mod+f` | Toggle fullscreen |
| `Mod+minus` | Show the scratchpad |
| `Mod+Shift+minus` | Move the window to the scratchpad |
| `Mod+Shift+f` | Firefox |
| `Mod+n` | Ranger in a terminal window |

### Usage
To get an idea of how to use this setup, see the [sway config](sway/config) and [waybar config](waybar/).

The weather module needs its binary built once:

```bash
cd ~/.config/waybar/scripts/weather-stats && go build -o weather-stats
```

Without it Waybar logs an error for that module every 30 minutes. The rest of the bar is unaffected.

### Install
1) Install the required packages. On Arch:
```bash
sudo pacman -S sway swayfx swaylock swayidle waybar fuzzel wlogout mako \
  sworkstyle fish ghostty grim slurp swappy light playerctl pavucontrol \
  nm-applet blueman-applet
```

2) Clone into place
```bash
git clone <this-repo> ~/.config
```

3) Clone the editor config as its own repo
```bash
git clone <nvim-repo> ~/.config/nvim
nvim   # installs plugins on first launch
```

4) Build the weather binary
```bash
cd ~/.config/waybar/scripts/weather-stats && go build -o weather-stats
```

5) Log in and start sway
```bash
sway
```

To apply changes to `sway/config` without restarting the session:
```bash
swaymsg reload
```
