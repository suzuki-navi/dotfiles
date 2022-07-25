# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 10000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=200000
SAVEHIST=200000
HISTFILE=~/.dotfiles/var/.zsh_history
setopt share_history
setopt extended_history
setopt hist_ignore_space

# ディレクトリスタックに重複する物は古い方を削除
setopt pushd_ignore_dups

# C-s, C-qを無効にする
setopt no_flow_control

setopt extended_glob

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*' group-name ''

# 単語の境界を設定
autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars " _-./;@"
zstyle ':zle:*' word-style unspecified

setopt auto_cd
setopt auto_pushd

# コマンドラインでも # 以降をコメントと見なす
setopt interactive_comments

autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '[%b]'
precmd () {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_`if git status >/dev/null 2>&1; then git config user.email; fi`"
}
export PROMPT="[%D{%m/%d %H:%M:%S}] %n@%m:%1(v|%F{blue}%1v%f:|)%F{green}%~%f $ "
export RPROMPT=""

alias reload='source ~/.zshrc'

md() {
  mkdir -p $1
  cd $1
}

if which peco >/dev/null; then
    # https://qiita.com/reireias/items/fd96d67ccf1fdffb24ed
    # https://qiita.com/sukebeeeeei/items/9b815e56a173a281f42f
    function peco-history-selection() {
        BUFFER=$(history -n -r 1 | awk '!a[$0]++' | peco --layout bottom-up --query "$LBUFFER")
        CURSOR=$#BUFFER
        zle reset-prompt
    }
    zle -N peco-history-selection
    bindkey '^R' peco-history-selection
fi

# https://qiita.com/reireias/items/fd96d67ccf1fdffb24ed
if [[ -n $(echo ${^fpath}/chpwd_recent_dirs(N)) && -n $(echo ${^fpath}/cdr(N)) ]]; then
    autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
    add-zsh-hook chpwd chpwd_recent_dirs
    zstyle ':completion:*' recent-dirs-insert both
    zstyle ':chpwd:*' recent-dirs-default true
    zstyle ':chpwd:*' recent-dirs-max 1000
    zstyle ':chpwd:*' recent-dirs-file "$HOME/.cache/chpwd-recent-dirs"
fi

# https://docs.aws.amazon.com/ja_jp/cli/latest/userguide/cli-configure-completion.html
if [[ -n "$(which aws_completer)" ]]; then
    autoload bashcompinit && bashcompinit
    complete -C $(which aws_completer) aws
fi

