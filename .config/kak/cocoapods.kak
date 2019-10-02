# https://cocoapods.org/
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾

# Detection
# ‾‾‾‾‾‾‾‾‾

hook global BufCreate (.*/Podfile|.*\.podspec) %{
    set-option buffer filetype ruby
}
