hook global BufCreate .*[.](androidlog) %{
    set-option buffer filetype androidlog
}

add-highlighter shared/androidlog regions
add-highlighter shared/androidlog/warn region '^\d\d-\d\d \d\d:\d\d:\d\d.\d\d\d \d+-\d+/\S+ W/\w+:' '(?=\d\d-\d\d \d\d:\d\d:\d\d.\d\d\d)' fill yellow
add-highlighter shared/androidlog/error region '^\d\d-\d\d \d\d:\d\d:\d\d.\d\d\d \d+-\d+/\S+ E/\w+:' '(?=\d\d-\d\d \d\d:\d\d:\d\d.\d\d\d)' fill red
add-highlighter shared/androidlog/assert region '^\d\d-\d\d \d\d:\d\d:\d\d.\d\d\d \d+-\d+/\S+ A/\w+:' '(?=\d\d-\d\d \d\d:\d\d:\d\d.\d\d\d)' fill red

hook -group androidlog-highlight global WinSetOption filetype=androidlog %{ add-highlighter window/androidlog ref androidlog }
hook -group androidlog-highlight global WinSetOption filetype=(?!androidlog).* %{ remove-highlighter window/androidlog }

