<div align="center">
    <h1>🏠</h1>
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
This repository is `~/.config` itself, initialised as a git repo. It is not a
bare repo, and there are no symlinks — every file here is the file the programs
actually read. The layout follows the
[XDG Base Directory Specification](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html),
so cloning this repo to `~/.config` on a machine with the same programs installed
gives a working setup.

It is not designed to be used with a
[Desktop Environment](https://wiki.archlinux.org/title/Desktop_environment).
[Sway](https://github.com/swaywm/sway) (via
[swayfx](https://github.com/WillPower3309/swayfx)) provides window management,
with [Waybar](https://github.com/Alexays/Waybar) as the status bar and
[fuzzel](https://github.com/junegunn/fuzzel) as the launcher.

`nvim/` is a separate repository — see [nvim/README.md](nvim/README.md).

### Structure
#### Desktop environment
* [**sway**/config](sway/config): the window manager config — keybindings, workspaces, window rules, autostart and output setup. The file itself lives in `sway/`.
* [**sway**/wallpaper.jpg](sway/wallpaper.jpg): the wallpaper set via `output * bg`.

#### Bar, launcher and session tools
* [**waybar**](waybar/): status bar. Transparent background, rounded floating bar. Modules: workspaces, window mode, clock, weather, volume, uptime, backlight, battery, network, cpu, memory, tray, scratchpad and lock.
* [**waybar**/scripts/weather-stats](waybar/scripts/weather-stats/): a small Go program that queries [wttr.in](https://wttr.in) for the weather module. Source is tracked; the compiled binary is not — see below.
* [**fuzzel**](fuzzel/): application launcher, bound to `Mod+d` and `Mod+space`.
* [**swaylock**](swaylock/): screen locker.
* [**wlogout**](wlogout/): logout / power off menu.
* [**wofi**](wofi/): general purpose menu, used as an application fallback and wallpaper picker.
* [**swappy**](swappy/): screenshot GUI, driven by `grim` and `slurp`.
* [**sworkstyle**](sworkstyle/): expands windows with mouse gestures.

#### Shell
* [**fish**](fish/): `config.fish` sets up `$PATH`, defines aliases and loads `conf.d/` and `functions/`. Plugin functions (`fisher`, `nvm`) are vendored in-tree so the shell works without a network fetch.
* [**envman**](envman/): generates `fish/load.fish`, which `config.fish` sources. Machine-specific environment, generated rather than committed.

#### Terminals
* [**ghostty**](ghostty/), [**alacritty**](alacritty/). Sway's default terminal is `kitty`, configured in `sway/config` via `set $term kitty`.

#### Applications
* [**lazygit**](lazygit/): terminal UI for git.
* [**pavucontrol.ini**](pavucontrol.ini): PulseAudio volume control defaults.
* [**autostart**](autostart/): desktop entries launched at login.
* [**systemd**](systemd/): user units, currently a daily `plan-notify` timer.
* [**mimeapps.list**](mimeapps.list): default application per MIME type.

#### Not tracked
Application data is excluded by [`.gitignore`](.gitignore): `discord/`,
`mozilla/`, `JetBrains/`, `obsidian/`, `vesktop/` and similar, plus generated
files (`fish/fish_variables`, `pulse/cookie`), the compiled weather binary, and
`gh/hosts.yml`, which contains GitHub OAuth tokens.

### Keybindings
`Mod` is the Super key. The authoritative list is in
[`sway/config`](sway/config); the most used:

| Key | Action |
| --- | --- |
| `Mod+d` / `Mod+space` | Launch application (fuzzel) |
| `Mod+Return` | Open a terminal |
| `Mod+Shift+e` | Logout menu (wlogout) |
| `Mod+Shift+backspace` | Lock the screen |
| `Mod+p` | Screenshot a region |
| `Mod+Shift+q` | Kill the focused window |
| `Mod+Shift+r` | Reload sway |
| `Mod+Left/Right/Up/Down` | Move focus |
| `Mod+Shift+Left/Right/Up/Down` | Move the window |
| `Mod+1` … `Mod+0` | Switch workspace |
| `Mod+Shift+1` … `Mod+Shift+0` | Move the focused window to a workspace |
| `Mod+backspace` | Toggle split |
| `Mod+t` / `Mod+e` | Tabbed / stacked layout |
| `Mod+Shift+space` | Toggle floating |
| `Mod+f` | Toggle fullscreen |
| `Mod+minus` | Show the scratchpad |
| `Mod+Shift+minus` | Move the window to the scratchpad |
| `Mod+Shift+f` | Firefox |
| `Mod+n` | Ranger in a kitty window |

### Usage
`sway/config` expands `$HOME` itself, and Waybar passes `exec` through a shell,
so `~` and `$HOME` work in both. Two exceptions need a real absolute path:

* `swaylock/config` — swaylock does no variable expansion. Change the username
  in the `image=` line if yours differs.
* `systemd/user/plan-notify.service` — uses systemd's `%h` (home) and `%t`
  (runtime dir) specifiers rather than `$HOME`, so no hardcoding is needed.

The weather module needs its binary built once:

```bash
cd ~/.config/waybar/scripts/weather-stats && go build -o weather-stats
```

Without it Waybar logs an error for that module every 30 minutes; the rest of
the bar is unaffected.

### Install
1) Install the required packages. On Arch:
```bash
sudo pacman -S sway swayfx swaylock swayidle waybar fuzzel wlogout mako \
  sworkstyle fish grim slurp swappy light playerctl pavucontrol \
  nm-applet blueman-applet foot
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
