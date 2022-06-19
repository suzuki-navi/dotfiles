
# Usage
# curl 'https://raw.githubusercontent.com/suzuki-navi/dotfiles/main/sync.sh' | bash
# or
# bash YOUR_PATH/sync.sh

dotpath=$(dirname $0)

cd $dotpath

if [ ! -e .dotfiles-home ]; then
    # curl ... | bash のような実行形式の場合

    if [ ! -e $HOME/.dotfiles ]; then
        mkdir $HOME/.dotfiles
        cd $HOME/.dotfiles
        git clone https://github.com/suzuki-navi/dotfiles.git .
    fi
fi

dotpath=$(pwd)

export DOTPATH=$dotpath

deploy_to_home() {
    relpath=$1
    if [ ! -e $HOME/$relpath ]; then
        echo ln -s $DOTPATH/$relpath $HOME/$relpath
        ln -s $DOTPATH/$relpath $HOME/$relpath
    elif [ -L $HOME/$relpath ]; then
        :
    else
        mkdir -p $(dirname $DOTPATH/var/before/$relpath)
        echo mv $HOME/$relpath $DOTPATH/var/before/$relpath
        mv $HOME/$relpath $DOTPATH/var/before/$relpath
        echo ln -s $DOTPATH/$relpath $HOME/$relpath
        ln -s $DOTPATH/$relpath $HOME/$relpath
    fi
}

deploy_to_home .test


