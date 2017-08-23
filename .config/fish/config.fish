set -U fish_pager_color_prefix cyan --bold --underline

if test -e ~/.env.fish
  source ~/.env.fish
end

tmux_pane_title
