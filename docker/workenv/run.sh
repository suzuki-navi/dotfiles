
set -Ceu

if [ "$#" == 0 ]; then
    exec $0 zsh
fi

DOTPATH=${DOTPATH:-}
if [ -z "$DOTPATH" ]; then
    DOTPATH=$(cd $(dirname $0)/../..; pwd)
fi

name=$(cd $(dirname $0); basename $(pwd))

bash $DOTPATH/docker/lib/build.sh $name >&2

# run_options を定義
. $DOTPATH/docker/lib/run-options.sh

work_dirs=$(perl $DOTPATH/docker/lib/mount-point-options.pl $DOTPATH $(cd $HOME; ls .))

work_dirs="$work_dirs -v /var/run/docker.sock:/var/run/docker.sock"

work_dirs="$work_dirs $(perl $DOTPATH/docker/lib/mount-ssh-point-options.pl $DOTPATH/credentials/.ssh $DOTPATH/private/.ssh)"

work_dirs="$work_dirs -v $DOTPATH/var/.ssh/known_hosts:$HOME/.ssh/known_hosts"

work_dirs="$work_dirs -v $DOTPATH/.zshenv:$HOME/.zshenv"
work_dirs="$work_dirs -v $DOTPATH/.zshrc:$HOME/.zshrc"

work_dirs="$work_dirs -v $DOTPATH/.tmux.conf:$HOME/.tmux.conf"

work_dirs="$work_dirs -v $DOTPATH:$HOME/.dotfiles"

if [ -e $DOTPATH/private/.gitconfig ]; then
    work_dirs="$work_dirs -v $DOTPATH/private/.gitconfig:$HOME/.gitconfig"
fi

if [ ! -e $DOTPATH/var/.zsh_history ]; then
    if [ -e $DOTPATH/private/.zsh_history ]; then
        cp $DOTPATH/private/.zsh_history $DOTPATH/var/.zsh_history
    else
        touch $DOTPATH/var/.zsh_history
    fi
fi

rm -rf $DOTPATH/var/.zshenv-local
echo "export PATH=$DOTPATH/bin:\$PATH" >> $DOTPATH/var/.zshenv-local
echo "export PATH=$DOTPATH/private/bin:\$PATH" >> $DOTPATH/var/.zshenv-local

if [ ! -e $DOTPATH/var/.ssh/known_hosts ]; then
    mkdir -p $DOTPATH/var/.ssh
    touch $DOTPATH/var/.ssh/known_hosts
fi

docker --config $DOTPATH/.docker/ run --rm $run_options $work_dirs dotfiles-$name bash /var/tmp/lib/entrypoint.sh $name "$@"

