#!/bin/sh

ln -s "$PWD/zsh" ~/.config/zsh

cat > ~/.zshenv <<EOF
export ZDOTDIR=~/.config/zsh
EOF

