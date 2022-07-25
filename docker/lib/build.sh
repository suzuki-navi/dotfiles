
set -Ceu

name=$1

cd $(dirname $0)/../$name

mkdir -p var

cat $(find $(ls | grep -v var) -type f) $(find ../lib -type f) | sha1sum | cut -b-40 >| var/hash.1

if [ ! -e var/hash ]; then
    touch var/hash
fi

if diff var/hash var/hash.1 >/dev/null 2>&1; then
    exit
fi

rm -rf var/lib
cp -r ../lib var/lib

docker build -t dotfiles-$name .

cp var/hash.1 var/hash

