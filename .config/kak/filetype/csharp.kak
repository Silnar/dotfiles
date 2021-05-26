# C#
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾

hook global BufCreate .*\.cs %{
    set-option buffer filetype csharp
}


# Initialization
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾

hook global WinSetOption filetype=csharp %{
    require-module csharp
}

hook -group csharp-highlight global WinSetOption filetype=csharp %{
    add-highlighter window/csharp ref csharp
    hook -once -always window WinSetOption filetype=.* %{ remove-highlighter window/csharp }
}


provide-module csharp %§

add-highlighter shared/csharp regions
add-highlighter shared/csharp/code default-region group
add-highlighter shared/csharp/string region %{(?<!')"} %{(?<!\\)(\\\\)*"} fill string
add-highlighter shared/csharp/comment region /\* \*/ fill comment
add-highlighter shared/csharp/inline_documentation region /// $ fill documentation
add-highlighter shared/csharp/line_comment region // $ fill comment

add-highlighter shared/csharp/code/ regex %{\b(this|true|false|null)\b} 0:value
add-highlighter shared/csharp/code/ regex "\b(void|byte|short|int|long|char|unsigned|float|boolean|double|string|object)\b" 0:type
add-highlighter shared/csharp/code/ regex "\b(while|for|if|else|do|static|switch|case|default|class|interface|struct|enum|goto|break|continue|return|try|catch|throw|new|namespace|using|is|as|await)\b" 0:keyword
add-highlighter shared/csharp/code/ regex "\b(sealed|public|internal|protected|private|abstract|override|readonly|native|const|async)\b" 0:attribute
add-highlighter shared/csharp/code/ regex "(?<!\w)@\w+\b" 0:meta

§
