#
## .zhhrc for mac
#

PROMPT=$'%{\e[0;37m%}%m%{\e[1;30m%}@%{\e[0;36m%}%2~%{\e[1;37m%} %# %{\e[0;00m%}' 
#RPROMPT=$'%{\e[0;31m%}%(?..%?) %{\e[1;32m%}%T%{\e[0;00m%}'

#PROMPT=$'%{\e[0;36m%}%2~%{\e[1;37m%} %# %{\e[0;00m%}' 
RPROMPT=$'%{\e[0;31m%}%(?..%?) %{\e[0;32m%}%T%{\e[0;00m%}'
      
HISTSIZE=1001
SAVEHIST=1000
HISTFILE=~/.zhistory
setopt APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt RM_STAR_SILENT
#setopt AUTO_PUSHD
#setopt PUSHD_IGNORE_DUPS

setopt AUTO_CD
setopt CORRECT
setopt CHASE_DOTS
setopt PUSHD_IGNORE_DUPS
setopt ALWAYS_TO_END
#setopt CORRECT_ALL

bindkey -v 
bindkey -M viins '\e?'     backward-delete-char
bindkey -M viins '\eH'     backward-delete-char 
bindkey -M viins '\e[3~'   delete-char

bindkey -M viins '\e[1;2C' forward-word
bindkey -M viins '\e[1;2D' backward-word 
bindkey -M viins '\e[F'    end-of-line 
bindkey -M viins '\e[H'    beginning-of-line

bindkey -M viins '\eOA'    up-line-or-history
bindkey -M viins '\eOB'    down-line-or-history
bindkey -M viins '\e[5~'   beginning-of-buffer-or-history
bindkey -M viins '\e[6~'   end-of-buffer-or-history

#export TERM="xterm-256color"
#export LSCOLORS=exfxcxdxbxegedabagacad

alias -g G='|egrep'
alias -g Gi='|egrep -i'
alias -g Gv='|egrep -v'
alias -g Gvi='|egrep -vi'
alias -g Giv='|egrep -iv'
alias -g M='|more'
alias -g H='|head'
alias -g T='|tail'
alias -g W='|while'

[ -f ~/.aliasrc ] && . ~/.aliasrc
[ -f ~/.exportrc ] && . ~/.exportrc

