# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="frisk"
ZSH_THEME="af-magic"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh

#export PS1="%{$fg[yellow]%}%/%{$reset_color%} $(git_prompt_info)%{$fg[blue]%}[%n@%m]%{$reset_color%}
#%{$fg_bold[black]%}λ > %{$reset_color%}"

function precmd()
{
	DECORATE=%{%(0?.$fg[green].$fg[red])%}·%{$FX[reset]%}
	export PROMPT="$DECORATE $FG[247]%n%{%(0?.$fg[green].$fg[red])%}@%{$FG[247]%}%m $DECORATE %{$FG[247]%}$(pwd | sed -e "s:$HOME:~:g;s:/: %{$FX[reset]%}>%{$FG[247]%} :g")%{$FX[reset]%} $DECORATE
$FG[247] λ %{%(0?.$fg[green].$fg[red])%}>%{$FG[247]%} $FX[reset]"
    export RPROMPT="$(git_prompt_info) $DECORATE$FG[247]%(10T. .)%(11T. .)%(12T. .)%@ %(1j.$DECORATE %j $FG[237]bg job .)%(2j.s .)%{$FX[reset]%}$DECORATE"
}


export EDITOR="subl"
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games
alias octave="/usr/bin/octave --silent"
alias open="gnome-open"
alias spice="wine /home/satej/.wine/dosdevices/c:/Program\ Files\ \(x86\)/LTC/LTspiceIV/scad3.exe"
alias hgrep="history | grep"
alias cinnamon-restart="cinnamon –replace -d :0.0 > /dev/null 2>&1 &"
alias top="htop"

function autopair_paren()
{
    LBUFFER+="("
    RBUFFER=")$RBUFFER"
}
zle -N autopair_paren autopair_paren
bindkey "(" autopair_paren


function autopair_brace()
{
    LBUFFER+="{"
    RBUFFER="}$RBUFFER"
}
zle -N autopair_brace autopair_brace
bindkey "{" autopair_brace

