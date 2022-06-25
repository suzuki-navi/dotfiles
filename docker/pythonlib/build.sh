cd $(dirname $0)

name=$(basename $(pwd))

cat $(find $(ls | grep -v var) -type f) | sha1sum | cut -b-40 > var/hash.1

if [ ! -e var/hash ]; then
    touch var/hash
fi

if diff var/hash var/hash.1 >/dev/null 2>&1; then
    exit
fi

docker build -t dotfiles-$name .

cat $(find $(ls | grep -v var) -type f) | sha1sum | cut -b-40 > var/hash

