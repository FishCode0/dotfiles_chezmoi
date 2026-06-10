if status is-interactive
# Commands to run in interactive sessions can go here
end

starship init fish | source
zoxide init fish | source
direnv hook fish | source

if status is-interactive
    atuin init fish | source
end

set -Ux GOPATH $HOME/go
fish_add_path $GOPATH/bin

fish_add_path /usr/local/go/bin
fish_add_path ~/.local/bin
fish_add_path ~/.cargo/bin

# abbr -a  bat "batcat"
# abbr -a ll "eza --all --long --icons"
# abbr -a la "eza --all --long -1"
# abbr -a l "eza --group-directories-first --icons"
abbr -a grep "grep --color=auto"
abbr -a apt "nala"
abbr -a g "git"
abbr -a s "sudo"
abbr  ga 'git add .'

# abbr -a df "df -h

# abbr -a du "du -h"

abbr -a df "duf"
abbr -a du "ncdu"
abbr -a help "tldr"
abbr -a fd "fdfind"
abbr -a ff "fdfind"
abbr -a update "sudo nala update && sudo nala upgrade"
# abbr -a td "tealdeer"
abbr -a tr "tldr"

# ouch
abbr -a od "ouch decompress"
abbr -a oc "ouch compress"
