# Makefile

hook global BufCreate .*/?mk %{
    set-option buffer filetype makefile
}

