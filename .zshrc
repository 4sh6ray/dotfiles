export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

autoload -U promptinit; promptinit
prompt pure

zplug 'zsh-users/zsh-autosuggestions'
zplug 'zsh-users/zsh-completions'
zplug "zsh-users/zsh-syntax-highlighting", defer:2
: "sshコマンド補完を~/.ssh/configから行う" && {
  function _ssh { compadd $(fgrep 'Host ' ~/.ssh/*/config | grep -v '*' |  awk '{print $2}' | sort) }
}

zplug "chrissicool/zsh-256color"

# 未インストール項目をインストールする
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# コマンドをリンクして、PATH に追加し、プラグインは読み込む
zplug load --verbose