function tmux_pane_title --on-variable PWD
    if [ -n "$TMUX" ]
        if [ $PWD = $HOME ]
            set title '~'
        else
            set title (basename $PWD)
        end

        printf "\033k%s\033\\" $title
    end
end

