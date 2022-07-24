
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

work_dirs=$(perl $DOTPATH/docker/lib/mount-point-options.pl $DOTPATH $(cd $HOME; ls -a .) -v .aws)
work_dirs="$work_dirs -v $HOME/.aws:$HOME/.aws"

docker run --rm $run_options $work_dirs dotfiles-$name bash /var/tmp/lib/entrypoint.sh $name "$command"

