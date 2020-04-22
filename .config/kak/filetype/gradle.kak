# https://gradle.org/
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾

# Detection
# ‾‾‾‾‾‾‾‾‾

# Use ruby highlighter
hook global BufCreate .*\.gradle %{
    set-option buffer filetype ruby
}
