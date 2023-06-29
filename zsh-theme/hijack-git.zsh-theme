autoload -Uz vcs_info
precmd() { vcs_info }

zstyle ':vcs_info:git:*' formats '%b%F{black}(%F{red}%c%F{black})%b'

setopt PROMPT_SUBST
PROMPT=$'%{$fg[black]%}%B┌─[%b%{$fg[black]%}%{$fg[yellow]%}%n%{$fg[red]%}@%{$fg[black]%}%{$fg[yellow]%}%m%{$fg[black]%}%B]%b%{$fg[black]%} - %b%{$fg[black]%}%B[%b%{$fg[yellow]%}%~%{$fg[black]%}%B]%b%{$fg[black]%} - %{$fg[black]%}%B[%b%{$fg[yellow]%}%!%{$fg[black]%}%B]%b%{$fg[black]%}
%{$fg[black]%}%B└─%B[%{$fg[red]%}~%{$fg[black]%}%B]%{$fg[black]%}%b '
RPROMPT='$(git_prompt_info)'
PS2=$' \e[0;34m%}%B>%{\e[0m%}%b '

git_prompt_info() {
  local current_dir=$PWD

  while [[ $PWD != '/' ]]; do
    if [[ -d .git && -n $(git rev-parse --is-inside-work-tree 2>/dev/null) ]]; then
      local ref=$(git symbolic-ref HEAD 2>/dev/null) || return
      echo " %{$fg[black]%}[%{$fg[red]%}${ref#refs/heads/}%{$fg[black]%}]"
      return
    fi
    
    cd ..
  done

  cd "$current_dir"
}
