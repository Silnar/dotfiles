#
# ~/.bashrc
#

if [ -f ~/.env.sh ]
then
  source ~/.env.sh
fi

export EDITOR='vim'

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

set_bash_color_prompt() {
	local NONE="\[\033[0m\]"	# unsets color to term's fg color

	# regular colors
	local K="\[\033[0;30m\]"	# black
	local R="\[\033[0;31m\]"	# red
	local G="\[\033[0;32m\]"	# green
	local Y="\[\033[0;33m\]"	# yellow
	local B="\[\033[0;34m\]"	# blue
	local M="\[\033[0;35m\]"	# magenta
	local C="\[\033[0;36m\]"	# cyan
	local W="\[\033[0;37m\]"	# white

	# emphasized (bolded) colors
	local EMK="\[\033[1;30m\]"
	local EMR="\[\033[1;31m\]"
	local EMG="\[\033[1;32m\]"
	local EMY="\[\033[1;33m\]"
	local EMB="\[\033[1;34m\]"
	local EMM="\[\033[1;35m\]"
	local EMC="\[\033[1;36m\]"
	local EMW="\[\033[1;37m\]"

	# background colors
	local BGK="\[\033[40m\]"
	local BGR="\[\033[41m\]"
	local BGG="\[\033[42m\]"
	local BGY="\[\033[43m\]"
	local BGB="\[\033[44m\]"
	local BGM="\[\033[45m\]"
	local BGC="\[\033[46m\]"
	local BGW="\[\033[47m\]"

  local BOXTL="\342\224\214"
  local BOXBL="\342\224\224"
  local DASH="\342\224\200"
  # local ARROWR="\342\225\274"
  local ARROWR=">"
  local X="\342\234\227"

  # local ERROR="\$(es=\$?; [[ \$es != 0 ]] && echo \"[${R}${X} \$es${W}]${DASH}\")"
  local ERROR="\$(es=\$?; [[ \$es != 0 ]] && echo \"[${R}\$es${W}]${DASH}\")"
  local USER="\$(if [[ \${EUID} == 0 ]]; then echo \"${R}\h\"; else echo \"${Y}\u${W}@${C}\h\"; fi)"
  local PS1L1="${W}${BOXTL}${DASH}$ERROR[$USER${W}]${DASH}[${G}\w${W}]\n"
  local PS1L2="${W}${BOXBL}${DASH}${ARROWR} ${NONE}"
  PS1=$PS1L1$PS1L2

	# without colors: PS1="[\u@\h \${NEW_PWD}]\\$ "
	# extra backslash in front of \$ to make bash colorize the prompt
}

set_bash_prompt() {
  # Set colorful PS1 only on colorful terminals.
  # dircolors --print-database uses its own built-in database
  # instead of using /etc/DIR_COLORS. Try to use the external file
  # first to take advantage of user additions. Use internal bash
  # globbing instead of external grep binary.

  # sanitize TERM:
  safe_term=${TERM//[^[:alnum:]]/?}
  match_lhs=""

  [[ -f ~/.dir_colors ]] && match_lhs="${match_lhs}$(<~/.dir_colors)"
  [[ -f /etc/DIR_COLORS ]] && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
  [[ -z ${match_lhs} ]] \
    && type -P dircolors >/dev/null \
    && match_lhs=$(dircolors --print-database)

  if [[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] ; then
    # we have colors :-)

    # Enable colors for ls, etc. Prefer ~/.dir_colors
    if type -P dircolors >/dev/null ; then
      if [[ -f ~/.dir_colors ]] ; then
        eval $(dircolors -b ~/.dir_colors)
      elif [[ -f /etc/DIR_COLORS ]] ; then
        eval $(dircolors -b /etc/DIR_COLORS)
      fi
    fi

    set_bash_color_prompt

    alias ls="ls --color=auto"
    alias dir="dir --color=auto"
    alias grep="grep --color=auto"
    alias dmesg='dmesg --color'

    # Uncomment the "Color" line in /etc/pacman.conf instead of uncommenting the following line...!

    # alias pacman="pacman --color=auto"

  else

    # show root@ when we do not have colors

    PS1="\u@\h \w \$([[ \$? != 0 ]] && echo \":( \")\$ "

    # Use this other PS1 string if you want \W for root and \w for all other users:
    # PS1="\u@\h $(if [[ ${EUID} == 0 ]]; then echo '\W'; else echo '\w'; fi) \$([[ \$? != 0 ]] && echo \":( \")\$ "

  fi

  PS2="> "
  PS3="> "
  PS4="+ "

  # Try to keep environment pollution down, EPA loves us.
  unset safe_term match_lhs
}

set_terminal_title() {
  # Show command name in terminal title bar
  # Link: http://stackoverflow.com/questions/10546217/how-to-view-process-name-in-terminal-emulator-tab-or-title-bar
  # Link: http://mg.pov.lt/blog/bash-prompt.html
  # If this is an xterm set the title to user@host:dir
  case "$TERM" in
  xterm*|rxvt*)
      # PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
      PROMPT_COMMAND='echo -ne "\033]0;$(_gitroot_=$(git rev-parse --show-toplevel 2>/dev/null) && echo ${PWD/#$(dirname $_gitroot_)\//\:} || echo ${PWD/#$HOME/\~})\007"'
  #
      # Show the currently running command in the terminal title:
      # http://www.davidpashley.com/articles/xterm-titles-with-bash.html
      show_command_in_title_bar()
      {
          case "$BASH_COMMAND" in
              *\033]0*)
                  # The command is trying to set the title bar as well;
                  # this is most likely the execution of $PROMPT_COMMAND.
                  # In any case nested escapes confuse the terminal, so don't
                  # output them.
                  ;;
              *)
                  # echo -ne "\033]0;${USER}@${HOSTNAME}: ${BASH_COMMAND}\007"
                  echo -ne "\033]0;${BASH_COMMAND}\007"
                  ;;
          esac
      }
      trap show_command_in_title_bar DEBUG
      ;;
  *)
      ;;
  esac
}

set_bash_prompt
set_terminal_title
