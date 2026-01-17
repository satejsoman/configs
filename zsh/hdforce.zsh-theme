# precmd hook
precmd_functions+=(hdforce_precmd)

hdforce_precmd() {
  # success/failure marker
  DECORATE="%{%(0?.%F{106}.%F{009})%}·%f"

  # build directory display
  case $PWD in
    $HOME)
      DN=""
      BN="~"
      ;;
    /)
      DN="›"
      BN=""
      ;;
    *)
      dnpwd=${PWD:h}
      bnpwd=${PWD:t}

      [[ $dnpwd != "/" ]] && dnpwd="$dnpwd/"

      DN=${dnpwd/#$HOME/~}
      DN=${DN//\// %{$FX[reset]%}›%F{102} }
      DN=${DN# }

      [[ $dnpwd == $bnpwd ]] && BN="" || BN=$bnpwd
      ;;
  esac

  pwd_info="%{$FX[reset]%}%F{102}$DN%F{75}$BN%{$FX[reset]%}"
  prompt_bar="%{%(0?.%F{106}.%F{009})%}≡%f"
  time_info="%F{102}%T%f"

  PROMPT="%K{128}$pwd_info $(virtualenv_prompt_info)$(conda_prompt_info)
%k$prompt_bar "
  RPROMPT="$(git_prompt_info) $DECORATE $time_info"
}

# ============================
#   Git prompt
# ============================

git_prompt_info() {
  git symbolic-ref HEAD >/dev/null 2>&1 || return

  local branch=$(git_current_branch)
  branch=${branch/feature\//%F{102}feature\/%F{220}}
  branch=${branch/bugfix\//%F{102}bugfix\/%F{220}}

  echo "$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_PREFIX$branch$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

ZSH_THEME_GIT_PROMPT_PREFIX="%F{220}"
ZSH_THEME_GIT_PROMPT_CLEAN="  "
ZSH_THEME_GIT_PROMPT_DIRTY="%F{75}◈ %f"
ZSH_THEME_GIT_PROMPT_SUFFIX=""
