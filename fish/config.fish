fish_add_path /opt/homebrew/bin
fish_add_path /opt/homebrew/sbin
fish_add_path /usr/local/bin
fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/.ghcup/bin
fish_add_path $HOME/.local/bin
fish_add_path $HOME/dev/bin
fish_add_path $HOME/opt/bin

set -U fish_greeting

set -gx EDITOR hx
set -gx VISUAL hx

zoxide init fish | source
fzf --fish | source

### ALIASES 
## ls
# general ls
alias ls "eza -R --git-ignore"
# ls cwd
alias lss eza

## start software
# btop
alias bt "btop -t -l -p 0"
# yazi
function y -d 'open yazi'
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

## system util
# clear buffer
alias c clear
# clear tmp
alias ct 'z ; rm -rfd tmp; mkdir tmp'

## pkg managers
# clean
alias clean 'brew autoremove; brew cleanup --prune=all'

## config
# open config.fish
alias nf 'hx ~/.config/fish/config.fish'
# source config.fish
alias sf 'source ~/.config/fish/config.fish'
# cd and open config
alias nc 'builtin cd ~/.config; hx .'

## helix
# cd and open log
alias n "builtin cd ~/log; hx $(date '+%Y')/$(date '+%m')"

## brew
# info
alias bi 'brew info'
# home
alias bh 'brew home'
# uses
alias bu 'brew uses --recursive --installed'

## fzf
# fuzzy search input string
function f -d 'fuzzy search input string'
    command fish -c "$argv" 2>&1 | fzf --ansi
end
