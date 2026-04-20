## Source from conf.d before our fish config
source /usr/share/cachyos-fish-config/conf.d/done.fish

## Set values
## Run fastfetch as welcome message
function fish_greeting
    fastfetch
end

# Format man pages
set -x MANROFFOPT "-c"
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"

# Set settings for https://github.com/franciscolourenco/done
set -U __done_min_cmd_duration 10000
set -U __done_notification_urgency_level low

## Environment setup
# Apply .profile: use this to put fish compatible .profile stuff in
if test -f ~/.fish_profile
  source ~/.fish_profile
end

# Append common directories for executable files to $PATH
fish_add_path ~/.local/bin ~/.cargo/bin ~/Applications/depot_tools

## Functions
# Functions needed for !! and !$ https://github.com/oh-my-fish/plugin-bang-bang
function __history_previous_command
  switch (commandline -t)
  case "!"
    commandline -t $history[1]; commandline -f repaint
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

if [ "$fish_key_bindings" = fish_vi_key_bindings ];
  bind -Minsert ! __history_previous_command
  bind -Minsert '$' __history_previous_command_arguments
else
  bind ! __history_previous_command
  bind '$' __history_previous_command_arguments
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
    set count (count $argv | tr -d \n)
    if test "$count" = 2; and test -d "$argv[1]"
        set from (echo $argv[1] | trim-right /)
        set to (echo $argv[2])
        command cp -r $from $to
    else
        command cp $argv
    end
end

## Useful aliases
# Replace ls with eza
alias ls='eza -al --color=always --group-directories-first --icons=always' # preferred listing
alias la='eza -a --color=always --group-directories-first --icons=always'  # all files and dirs
alias ll='eza -l --color=always --group-directories-first --icons=always'  # long format
alias lt='eza -aT --color=always --group-directories-first --icons=always' # tree listing
alias l.="eza -a | grep -e '^\.'"                                     # show only dotfiles

# Common use
alias grubup="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias fixpacman="sudo rm /var/lib/pacman/db.lck"
alias tarnow='tar -acf '
alias untar='tar -zxvf '
alias wget='wget -c '
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias hw='hwinfo --short'                                   # Hardware Info
alias big="expac -H M '%m\t%n' | sort -h | nl"              # Sort installed packages according to size in MB
alias gitpkg='pacman -Q | grep -i "\-git" | wc -l'          # List amount of -git packages
alias update='sudo cachyos-rate-mirrors && sudo pacman -Syu'

# Get fastest mirrors
alias mirror="sudo cachyos-rate-mirrors"

# Help people new to Arch
alias apt='man pacman'
alias apt-get='man pacman'
alias tb='nc termbin.com 9999'

# Cleanup orphaned packages
alias cleanup='sudo pacman -Rns (pacman -Qtdq)'

# Get the error messages from journalctl
alias jctl="journalctl -p 3 -xb"

# Recent installed packages
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"

# Print aliases to console
alias cachy="echo -e 'cachy aliases' ;\
	echo -e '\t backup \t make a backup of a single file' ;\
	echo -e '\t copy \t\t copy srcdir destdir' ;\
	echo -e 'Replace ls with eza' ;\
	echo -e '\t ls \t\t preferred listing' ;\
	echo -e '\t la \t\t all files and dirs' ;\
	echo -e '\t ll \t\t long format' ;\
	echo -e '\t lt \t\t tree listing' ;\
	echo -e '\t l. \t\t show only dotfiles' ;\
echo -e 'Common use' ;\
	echo -e '\t grubup \t update grub configuration' ;\
	echo -e '\t tarnow \t compress' ;\
	echo -e '\t untar \t\t extract' ;\
	echo -e '\t psmem \t\t sort processes by memory usage' ;\
	echo -e '\t psmem10 \t 10 top processes by memory usage' ;\
	echo -e '\t .. \t\t cd ..' ;\
	echo -e '\t ... \t\t cd ../..' ;\
	echo -e '\t .... \t\t cd ../../..' ;\
	echo -e '\t ..... \t\t cd ../../../..' ;\
	echo -e '\t ...... \t cd ../../../../..' ;\
	echo -e '\t dir' ;\
	echo -e '\t vdir' ;\
	echo -e '\t grep \t\t with colors' ;\
	echo -e '\t fgrep \t\t with colors' ;\
	echo -e '\t egrep \t\t with colors' ;\
	echo -e '\t hw \t\t Hardware Info' ;\
	echo -e '\t big \t\t Sort installed packages according to size in MB' ;\
	echo -e '\t gitpkg \t List amount of -git packages' ;\
	echo -e '\t update \t rate mirrors and update system' ;\
	echo -e '\t mirror \t Get fastest mirrors' ;\
echo -e 'Help people new to Arch' ;\
	echo -e '\t apt \t\t man pacman' ;\
	echo -e '\t apt-get \t\t man pacman' ;\
	echo -e '\t tb \t\t post content to termbin.com' ;\
echo -e 'Other ';\
	echo -e '\t cleanup \t Cleanup orphaned packages' ;\
	echo -e '\t jctl \t\t Get the error messages from journalctl' ;\
	echo -e '\t rip \t\t Recent installed packages'"