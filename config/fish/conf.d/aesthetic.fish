# Apps decorativas — usan colores de Kitty/Noctalia en terminal

set -gx AESTHETIC_ENV "$HOME/.config/aesthetic/noctalia.env"
if test -f $AESTHETIC_ENV
    source $AESTHETIC_ENV
end

function bonsai
    set -l colors $CBONSAI_COLORS
    if test (count (string split , $colors)) -ne 4
        set colors 8,9,7,15
    end
    cbonsai -l -i -k $colors $argv
end

function lava
    lavat $argv
end

function pipes
    pipes.sh $argv
end

function clock
    set -l color $TTY_CLOCK_COLOR
    if test -z "$color"
        set color 7
    end
    tty-clock -C $color -t -c $argv
end
