## Source from conf.d before our fish config
if test -f /usr/share/cachyos-fish-config/conf.d/done.fish
    source /usr/share/cachyos-fish-config/conf.d/done.fish
end

## Set values
## Run fastfetch as welcome message
function fish_greeting
    if type -q fastfetch
        fastfetch
    end
end

# Format man pages
if type -q bat
    set -x MANROFFOPT "-c"
    set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"
end

# Set settings for https://github.com/franciscolourenco/done
set -U __done_min_cmd_duration 10000
set -U __done_notification_urgency_level low

## Environment setup
# Apply .profile: use this to put fish compatible .profile stuff in
if test -f ~/.fish_profile
  source ~/.fish_profile
end

# Append common directories for executable files to $PATH
for p in ~/.local/bin ~/.cargo/bin ~/Applications/depot_tools
    if test -d $p
        fish_add_path $p
    end
end

## Functions
# Functions needed for !! and !$ https://github.com/oh-my-fish/plugin-bang-bang
function __history_previous_command
  switch (commandline -t)
  case "!"
    commandline -t $history[1];
    commandline -f repaint
  case "*"
    commandline -i !
  end
end

function __history_previous_command_arguments
  switch (commandline -t)
  case "!"
    commandline -t ""
    commandline -f history-token-search-backward
  case "*"
    commandline -i '$'
  end
end

function fish_user_key_bindings
    if test "$fish_key_bindings" = fish_vi_key_bindings
        bind -Minsert ! __history_previous_command
        bind -Minsert '$' __history_previous_command_arguments
    else
        bind ! __history_previous_command
        bind '$' __history_previous_command_arguments
    end
end

# Fish command history
function history
    builtin history --show-time='%F %T ' $argv
end

function backup --argument filename
    cp $filename $filename.bak
end

# Copy DIR1 DIR2
function copy
    set count (count $argv)
    if test "$count" = 2; and test -d "$argv[1]"
        set from (string trim --right --chars=/ $argv[1])
        set to (echo $argv[2])
        command cp -r $from $to
    else
        command cp $argv
    end
end

# Sort installed packages according to size in MB
function big
    expac -H M '%m\t%n' | sort -h | nl
end

# List amount of -git packages
function gitpkg
    pacman -Q | grep -i "\-git" | wc -l
end

# Recent installed packages
function rip
    expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl
end

# Cleanup orphaned packages
function cleanup
    set -l orphans (pacman -Qtdq)
    if test -n "$orphans"
        sudo pacman -Rns $orphans
    else
        echo "No orphaned packages found."
    end
end

function psmem
    ps auxf | sort -nr -k 4
end

function psmem10
    ps auxf | sort -nr -k 4 | head -10
end

## Useful aliases
# Replace ls with eza
alias ls='eza -al --color=always --group-directories-first --icons=always' # preferred listing
alias la='eza -a --color=always --group-directories-first --icons=always'  # all files and dirs
alias ll='eza -l --color=always --group-directories-first --icons=always'  # long format
alias lt='eza -aT --color=always --group-directories-first --icons=always' # tree listing
alias l.="eza -a | grep -e '^\.'"                                          # show only dotfiles

# System & Pacman
alias grubup="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias fixpacman="sudo rm /var/lib/pacman/db.lck"
alias tarnow='tar -acf '
alias untar='tar -zxvf '
alias wget='wget -c '

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

# Tools
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias hw='hwinfo --short'

# Safety aliases (Confirmation before overwriting/deleting)
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"

# Updates & Mirrors
alias update='sudo cachyos-rate-mirrors; and sudo pacman -Syu'
alias mirror="sudo cachyos-rate-mirrors"

# Help people new to Arch
alias apt='man pacman'
alias apt-get='man pacman'
alias tb='nc termbin.com 9999'

# Logs
alias jctl="journalctl -p 3 -xb"
