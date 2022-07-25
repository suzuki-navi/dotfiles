
name="$1"
command="$2"

HOST_UID=${HOST_UID:-0}
HOST_GID=${HOST_GID:-0}
HOST_USER=${HOST_USER:-}

# ホスト側の実行ユーザーと同一のUID, GIDを持つユーザーを作成
groupadd -g $HOST_GID -o $HOST_USER
useradd  -u $HOST_UID -g $HOST_GID -o $HOST_USER
usermod -aG sudo $HOST_USER
export HOME=/home/$HOST_USER

chown $HOST_USER $HOME

if [ -e $DOTPATH/docker/$name/entrypoint2.sh ]; then
    bash $DOTPATH/docker/$name/entrypoint2.sh
fi

if [ -e $DOTPATH/docker/$name/entrypoint3.sh ]; then
    su $HOST_USER -c "bash $DOTPATH/docker/$name/entrypoint3.sh"
fi

if [ -t 1 ]; then
    su -P $HOST_USER -c "$command"
else
    su $HOST_USER -c "$command"
fi

