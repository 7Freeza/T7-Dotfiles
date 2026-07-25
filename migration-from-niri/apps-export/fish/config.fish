source /usr/share/cachyos-fish-config/cachyos-config.fish

starship init fish | source

# >>> grok installer >>>
fish_add_path $HOME/.grok/bin
# <<< grok installer <<<

# Steam: fix black screen on niri (OpenGL compositor bug)
function steam --wraps /usr/bin/steam
    command /usr/bin/steam -system-composer $argv
end
