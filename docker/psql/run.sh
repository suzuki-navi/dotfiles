
set -Ceu

if [ "$#" == 0 ]; then
    exec $0 psql
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

if [ ! -e $DOTPATH/var/.psql_history ]; then
    if [ -e $DOTPATH/private/.psql_history ]; then
        cp $DOTPATH/private/.psql_history $DOTPATH/var/.psql_history
    else
        touch $DOTPATH/var/.psql_history
    fi
fi

work_dirs="$work_dirs -v $DOTPATH/var/.psql_history:$HOME/.psql_history"

run_options="$run_options -e PAGER"

run_options="$run_options -e PGPASSWORD"
run_options="$run_options -e PGSSLMODE"

docker --config $DOTPATH/.docker/ run --rm $run_options $work_dirs dotfiles-$name bash /var/tmp/lib/entrypoint.sh $name "$@"

