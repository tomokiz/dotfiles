#last Update 2019/05/06

# if [ $SHLVL -gt 1 ]; then
: "一般的な設定" && {
setopt correct # 入力しているコマンド名が間違っている場合にもしかして：を出す。
setopt nobeep # ビープを鳴らさない
setopt no_tify # バックグラウンドジョブが終了したらすぐに知らせる。
setopt auto_cd # ディレクトリ名を入力するだけでcdできるようにする
}
#ディレクトリを作って移動
#mkdircd()
#{
#    mkdir $1
#    cd $1
#}

autoload -Uz colors
colors

#PROMPTが呼ばれる前に実行される
precmd () {}
PROMPT="%B%(!.%{${fg[red]}%}.%{${fg[green]}%}){%n}%{${fg[blue]}%}%~%{${fg[yellow]}%} >%{${reset_color}%}%b"


#=============================
# source zsh-syntax-highlighting
#=============================
if [ -f ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
zstyle ':completion:*:default' menu select=2

function ranger() {
if [ -z "$RANGER_LEVEL" ]; then
/usr/local/bin/ranger $@
else
exit
fi
}
# zsh-completionsを利用する Github => zsh-completions
fpath=(~/.zsh-completions $fpath)
autoload -U compinit && compinit # 補完機能の強化
# fi

# for w3m
export WWW_HOME="http://google.com/"

#aliases
alias l=ls
alias la='ls -a'
alias ll='ls -al'
alias cmx='chmod +x'

HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt extended_history

# 初回シェル時のみ tmux実行
# if [ $SHLVL = 1 ]; then
# tmux
# fi
