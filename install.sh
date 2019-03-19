#!/bin/sh
set -e

CUR_DIR=$(cd `dirname $0`; pwd)

if [ -e $HOME/.vimrc ] ; then
    mv $HOME/.vimrc $HOME/.vimrc.old
fi
cp $CUR_DIR/vimrc $HOME/.vimrc
cp $CUR_DIR/plugins.vimrc $HOME/.plugins.vimrc

if [ "$CUR_DIR" = "$HOME/.vim/pack" ] ; then
    exit 0
fi
mkdir -p $HOME/.vim/pack
if [ -d $HOME/.vim/pack/plugins ] ; then
    mv $HOME/.vim/pack/plugins $HOME/.vim/pack/plugins.old
fi
ln -sf $CUR_DIR/plugins $HOME/.vim/pack/plugins

