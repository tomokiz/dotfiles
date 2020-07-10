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
# git ブランチ名を色付きで表示させるメソッド
function prompt-git {
  local branch_name st branch_status

  if [ ! -e  ".git" ]; then
    # git 管理されていないディレクトリは何も返さない
    return
  fi
  branch_name=`git rev-parse --abbrev-ref HEAD 2> /dev/null`
  st=`git status 2> /dev/null`
  if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
    # 全て commit されてクリーンな状態
    branch_status="%{${fg[green]}%}"
  elif [[ -n `echo "$st" | grep "^Untracked files"` ]]; then
    # git 管理されていないファイルがある状態
    branch_status="%{${fg[red]}%}"
  elif [[ -n `echo "$st" | grep "^Changes not staged for commit"` ]]; then
    # git add されていないファイルがある状態
    branch_status="%{${fg[red]}%}"
  elif [[ -n `echo "$st" | grep "^Changes to be committed"` ]]; then
    # git commit されていないファイルがある状態
    branch_status="%{${fg[yellow]}%}"
  elif [[ -n `echo "$st" | grep "^rebase in progress"` ]]; then
    # コンフリクトが起こった状態
    echo "%{${fg[red]}%}!(no branch)"
    return
  else
    # 上記以外の状態の場合
    branch_status="%{${fg[blue]}%}"
  fi
  # ブランチ名を色付きで表示する
  echo "${branch_status}($branch_name)"
}

# プロンプトが表示されるたびにプロンプト文字列を評価、置換する
setopt prompt_subst

# プロンプトにメソッドの結果を表示させる
PROMPT='%B%(!.%{${fg[red]}%}.%{${fg[green]}%})_%n_`prompt-git`%{${fg[blue]}%}%~%{${fg[yellow]}%} > %{${fg[white]}%}%b'


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

#path
export PATH=$PATH:$HOME/bin

#aliases
alias l=ls
alias la='ls -a'
alias ll='ls -al'
alias cmx='chmod +x'
alias help='echo help | bash'

HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt extended_history

# 初回シェル時のみ tmux実行
# if [ $SHLVL = 1 ]; then
# tmux
# fi

unsetopt promptcr

function command_not_found_handler() {
    if test -e $1;    then
        if [ "$(file --mime-encoding -L $1 | awk '{print $2}')" = 'binary' ];
        then
            echo "zsh: command not found: $1"
        else
            cat "$1"
        fi
    fi
}
