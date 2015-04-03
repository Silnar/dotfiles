#!/bin/sh

ln -s "$PWD/vim/vimrc" ~/.vimrc

[[ -e ~/.vim ]] || mkdir ~/.vim
ln -s "$PWD/vim/snippets" ~/.vim/snippets
