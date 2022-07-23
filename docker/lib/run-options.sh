
user=$(whoami)
uid=$(id -u $user)
gid=$(id -g $user)
if [ -t 0 ]; then
    term_opt="-it"
else
    term_opt=""
fi

work_dirs=$(echo $(cd $HOME; find * -maxdepth 0 -type d | perl -nle 'print "-v $ENV{HOME}/$_:$ENV{HOME}/$_"'))
if [ $DOTPATH != $HOME/dotfiles ]; then
    work_dirs="$work_dirs -v $DOTPATH:$DOTPATH"
fi

envs="-e DOTPATH=$DOTPATH"
if [ -v HTTP_PROXY ]; then
    envs="$envs -e HTTP_PROXY=$HTTP_PROXY"
fi
if [ -v HTTP_PROXYS ]; then
    envs="$envs -e HTTPS_PROXY=$HTTPS_PROXY"
fi
if [ -v NO_PROXY ]; then
    envs="$envs -e NO_PROXY=$NO_PROXY"
fi

run_options="$term_opt -e HOST_UID=$uid -e HOST_GID=$gid -e HOST_USER=$user -w $(pwd) $work_dirs $envs"

