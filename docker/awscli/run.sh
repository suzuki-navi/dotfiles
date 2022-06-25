
DOTPATH=${DOTPATH:-}
if [ -z "$DOTPATH" ]; then
    DOTPATH=$(cd $(dirname $0)/../..; pwd)
fi

work_dirs=$(echo $(cd $HOME; find * -maxdepth 0 -type d | perl -nle 'print "-v $ENV{HOME}/$_:$ENV{HOME}/$_"'))
if [ $DOTPATH != $HOME/dotfiles ]; then
    work_dirs="$work_dirs -v $DOTPATH:$DOTPATH"
fi
work_dirs="$work_dirs -v $HOME/.aws:$HOME/.aws"

envs="$envs -e HTTP_PROXY=$HTTP_PROXY -e HTTPS_PROXY=$HTTPS_PROXY -e NO_PROXY=$NO_PROXY"
envs="$envs -e HOME=$HOME"

user=$(whoami)
uid=$(id -u $user)
gid=$(id -g $user)
if [ -t 0 ]; then
    term_opt="-it"
else
    term_opt=""
fi

docker run $term_opt --rm -w "$(pwd)" $envs $work_dirs -u $uid:$gid amazon/aws-cli "$@"

