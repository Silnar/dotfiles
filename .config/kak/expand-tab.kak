# Expand tab to spaces
# https://github.com/mawww/kakoune/wiki/Indentation-and-Tabulation
# Press tab to insert spaces.
hook global InsertChar \t %{ try %{
    execute-keys -draft h %opt{indentwidth}@
} }
