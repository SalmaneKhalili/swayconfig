if status is-interactive
    # Commands to run in interactive sessions can go here
    fish_add_path $HOME/.local/bin
    fish_add_path $HOME/worldbanc/private/bin
      #Golang APPs
    fish_add_path $HOME/go/bin/
    # CloudNine plan
    alias plan='python3 ~/Repositories/CloudNine/plan/plan.py'
    alias cloudnine='cd ~/Repositories/CloudNine'
    # Boot.dev Linux Course
    alias reload='source ~/.config/fish/config.fish'
end

# Generated for envman. Do not edit.
if test -s ~/.config/envman/load.fish; and not set -q g_envman_load_fish
    source ~/.config/envman/load.fish
end
