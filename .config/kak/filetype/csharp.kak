# C#
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾

# Detection
# ‾‾‾‾‾‾‾‾‾

# Use ruby highlighter
hook global BufCreate .*\.cs %{
    set-option buffer filetype c
}
