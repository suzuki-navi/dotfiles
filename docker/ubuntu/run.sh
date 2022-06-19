
if [ "$#" == 0 ]; then
    #echo "command not specified" >&2
    #exit 1
    command="bash"
else
    command="$*"
fi

DOTPATH=${DOTPATH:-}
if [ -z "$DOTPATH" ]; then
    DOTPATH=$(cd $(dirname $0)/../..; pwd)
fi

this_docker_path=$DOTPATH/docker/ubuntu

bash $this_docker_path/build.sh

work_dirs=$(echo $(cd $HOME; find * -maxdepth 0 -type d | perl -nle 'print "-v $ENV{HOME}/$_:$ENV{HOME}/$_"'))
if [ $DOTPATH != $HOME/dotfiles ]; then
    work_dirs="$work_dirs -v $DOTPATH:$DOTPATH"
fi

envs="-e DOTPATH=$DOTPATH"
envs="$envs -e HTTP_PROXY=$HTTP_PROXY -e HTTPS_PROXY=$HTTPS_PROXY -e NO_PROXY=$NO_PROXY"

user=$(whoami)
uid=$(id -u $user)
gid=$(id -g $user)
docker run -it --rm -e HOST_UID=$uid -e HOST_GID=$gid -e HOST_USER=$user -w "$(pwd)" $envs $work_dirs dotfiles-ubuntu bash $this_docker_path/entrypoint.sh "$command"

