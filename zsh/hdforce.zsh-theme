# color vars
eval my_gray='$FG[237]'
eval my_orange='$FG[220]'
eval my_lblue='$FG[075]'

# primary prompt
function precmd()
{
DECORATE=%{%(0?.$FG[106].$FG[009])%}·%{$FX[reset]%}
if [[ $PWD == $HOME ]]; then
	DN=""
	BN="~"
elif [[ $PWD == / ]]; then
	DN="›"
	BN=""
else
	dnpwd=$(dirname $PWD)
	bnpwd=$(basename $PWD)
	if [[ $dnpwd != "/" ]]; then
		dnpwd=$dnpwd/
	fi
	DN=$(echo $dnpwd | sed -e "s:$HOME:~:g;s:/: %{$FX[reset]%}›%{$FG[102]%} :g")
	if [[ ${DN[0,1]} == " " ]]; then
		DN=${DN:1}
	fi
	if [[ "$dnpwd" == "$bnpwd" ]]; then
		BN=""
	else 
		BN=$bnpwd
	fi
fi

pwd_info="%{$FX[reset]%}%{$FG[102]%}$DN%{$FG[075]%}$BN%{$FX[reset]%}"
# prompt_bar="%{%(0?.$FG[106].$FG[009])%}|$FX[reset]"
prompt_bar="%{%(0?.$FG[106].$FG[009])%}≡$FX[reset]"
time_info="$FG[102]%T%{$FX[reset]%}"
bg_info="%(1j.%j $FG[237]bg job .)%(2j.s .)"

export PROMPT="%{$BG[128]%}$pwd_info $(virtualenv_prompt_info)$(conda_prompt_info) 
$FX[reset]$prompt_bar "

export RPROMPT="$(git_prompt_info) $DECORATE $time_info"
}

function git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  pretty_branch=$(echo $(git_current_branch) | sed -e "s:feature/:%{$FG[102]%}feature/%{$FG[220]%}:g" -e "s:bugfix/:%{$FG[102]%}bugfix/%{$FG[220]%}:g")
  echo "$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_PREFIX$pretty_branch$ZSH_THEME_GIT_PROMPT_SUFFIX"
}
# git settings
# ZSH_THEME_GIT_PROMPT_PREFIX="$FG[006]$BG[000]⎇ "
# ZSH_THEME_GIT_PROMPT_PREFIX="%{$FG[006]$BG[000]%} "
# ZSH_THEME_GIT_PROMPT_PREFIX="%{$FG[006]$BG[000]%} » "
# ZSH_THEME_GIT_PROMPT_PREFIX=": %{$FG[006]$BG[000]%}"
ZSH_THEME_GIT_PROMPT_PREFIX="%{$FG[220]%}"
# ZSH_THEME_GIT_PROMPT_PREFIX=" %{$FG[006]$BG[000]%}"
ZSH_THEME_GIT_PROMPT_CLEAN="  "
#ZSH_THEME_GIT_PROMPT_DIRTY="%{$FG[075]%}⍅ %{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$FG[075]%}◈ %{$reset_color%}"
# ZSH_THEME_GIT_PROMPT_SUFFIX="%{$BG[006]$FG[000]$reset_color%} "
ZSH_THEME_GIT_PROMPT_SUFFIX=""
