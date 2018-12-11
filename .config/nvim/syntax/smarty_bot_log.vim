syntax match smarty_bot_log_timestamp '^\d\{2}:\d\{2}:\d\{2}\.\d\{3}'
syntax match smarty_bot_log_error 'ERROR'

highlight default link smarty_bot_log_timestamp Number
highlight default link smarty_bot_log_error Error
