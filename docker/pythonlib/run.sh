
set -Ceu

if [ "$#" == 0 ]; then
    command="python"
else
    command="$*"
fi

DOTPATH=${DOTPATH:-}
if [ -z "$DOTPATH" ]; then
    DOTPATH=$(cd $(dirname $0)/../..; pwd)
fi

name=$(cd $(dirname $0); basename $(pwd))

bash $DOTPATH/docker/lib/build.sh $name >&2

# run_options を定義
. $DOTPATH/docker/lib/run-options.sh

run_options="$run_options -v $HOME/.aws:$HOME/.aws"

docker run --rm $run_options dotfiles-$name bash /var/tmp/lib/entrypoint.sh $name "$command"

