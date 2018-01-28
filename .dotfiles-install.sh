#!/bin/bash

git --git-dir=$HOME/.dotfiles --work-tree=$HOME init
git --git-dir=$HOME/.dotfiles --work-tree=$HOME remote add origin https://github.com/Silnar/dotfiles.git
git --git-dir=$HOME/.dotfiles --work-tree=$HOME fetch
git --git-dir=$HOME/.dotfiles --work-tree=$HOME checkout master
git --git-dir=$HOME/.dotfiles --work-tree=$HOME submodule update --init --recursive
