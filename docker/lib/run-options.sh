
user=$(whoami)
uid=$(id -u $user)
gid=$(id -g $user)
if [ -t 0 ] && [ -t 1 ]; then
    term_opt="-it"
else
    term_opt=""
fi

envs=""
envs="$envs -e HOME=$HOME"
envs="$envs -e DOTPATH=$DOTPATH"
if [ -v HTTP_PROXY ]; then
    envs="$envs -e HTTP_PROXY=$HTTP_PROXY"
fi
if [ -v HTTP_PROXYS ]; then
    envs="$envs -e HTTPS_PROXY=$HTTPS_PROXY"
fi
if [ -v NO_PROXY ]; then
    envs="$envs -e NO_PROXY=$NO_PROXY"
fi

run_options="$term_opt -e HOST_UID=$uid -e HOST_GID=$gid -e HOST_USER=$user -w $(pwd) $envs"

