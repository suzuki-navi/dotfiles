
dotpath=$(dirname $0)

cd $dotpath

if [ ! -e .dotfiles-home ]; then
    # curl ... | bash のような実行形式の場合

    cd $HOME
    exit 1 # TODO
    # 作りかけ
    #if [ ! -e .dotfiles ]; then
    #    mkdir .dotfiles
    #fi
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


