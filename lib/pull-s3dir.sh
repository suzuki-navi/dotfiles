#!/bin/bash

set -Ceu

DOTPATH=${DOTPATH:-}
if [ -z "$DOTPATH" ]; then
    DOTPATH=$(cd $(dirname $0)/..; pwd)
fi

name=$1

if [ -z "$name" ]; then
    echo "Name not specified" >&2
    exit 1
fi
if [ -e "$HOME/$name" ]; then
    echo "Found: $HOME/$name" >&2
    exit 1
fi

. $DOTPATH/private/s3-config.sh

archive_dir=$DOTPATH/archive
mkdir -p $archive_dir

s3_last_ls_line=$($DOTPATH/bin/aws s3 ls s3://$s3_archive_bucket/$s3_archive_prefix/$name.tar.gz. | LC_ALL=C sort | tail -n1)
if [ -z "$s3_last_ls_line" ]; then
    echo "Not found: s3://$s3_archive_bucket/$s3_archive_prefix/$name.tar.gz" >&2
    exit 1
fi
s3_last_fname=$(echo "$s3_last_ls_line" | awk '{print $4}')
s3_last_num=$(echo "$s3_last_fname" | sed -E -e 's/^.+\.tar\.gz\.([0-9]+)$/\1/')
if [ -z "$s3_last_num" ]; then
    echo "Not found: s3://$s3_archive_bucket/$s3_archive_prefix/$name.tar.gz" >&2
    exit 1
fi

mkdir -p $archive_dir
echo "pull from s3://$s3_archive_bucket/$s3_archive_prefix/$name.tar.gz.$s3_last_num"
$DOTPATH/bin/aws s3 cp s3://$s3_archive_bucket/$s3_archive_prefix/$name.tar.gz.$s3_last_num $archive_dir/$name.tar.gz.$s3_last_num

(
    cd $HOME
    tar xzf $archive_dir/$name.tar.gz.$s3_last_num
)

bash $DOTPATH/lib/dir-hash.sh $name $archive_dir/$name.tar.gz $s3_last_num

