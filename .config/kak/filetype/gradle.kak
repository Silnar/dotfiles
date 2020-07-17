# https://gradle.org/
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾

# Detection
# ‾‾‾‾‾‾‾‾‾

# Use ruby highlighter
hook global BufCreate .*\.gradle %{
    set-option buffer filetype java
}
hook global BufCreate .*/gradle.properties %{
    set-option buffer filetype toml
}
