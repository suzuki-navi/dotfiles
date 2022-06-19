
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
this_docker_path=$DOTPATH/docker/$name

bash $this_docker_path/build.sh >&2

work_dirs=$(echo $(cd $HOME; find * -maxdepth 0 -type d | perl -nle 'print "-v $ENV{HOME}/$_:$ENV{HOME}/$_"'))
if [ $DOTPATH != $HOME/dotfiles ]; then
    work_dirs="$work_dirs -v $DOTPATH:$DOTPATH"
fi
work_dirs="$work_dirs -v $HOME/.aws:$HOME/.aws"

envs="-e DOTPATH=$DOTPATH"
envs="$envs -e HTTP_PROXY=$HTTP_PROXY -e HTTPS_PROXY=$HTTPS_PROXY -e NO_PROXY=$NO_PROXY"

user=$(whoami)
uid=$(id -u $user)
gid=$(id -g $user)
if [ -t 0 ]; then
    term_opt="-it"
else
    term_opt=""
fi
docker run $term_opt --rm -e HOST_UID=$uid -e HOST_GID=$gid -e HOST_USER=$user -w "$(pwd)" $envs $work_dirs dotfiles-$name bash $this_docker_path/entrypoint.sh "$command"

