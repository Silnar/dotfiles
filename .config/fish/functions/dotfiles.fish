function dotfiles
	git --work-tree=$HOME --git-dir=$HOME/.dotfiles $argv;
end
