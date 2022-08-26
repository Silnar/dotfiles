M = {}

local ident_char = "[a-zA-Z0-9_`\\[\\]\\*&|]"
local class_name =
  ident_char .. "+" .. "%(\\." .. ident_char .. "+)*" .. --namespace
  [[%(\/%(\<%(]] .. ident_char .. [[+)?\>)?]] .. ident_char .. [[+]] .. [[)?]] .. -- /<>__Something
  [[%(\<.{-}\>)?]] -- generics

local method_name =
  [[:]] .. -- :
  [[%(]] .. [[\<%(]] .. ident_char .. [[+)?\>]] .. [[)?]] .. -- optinal name in angle brackets <>
  [[%(]] ..
    [[%(]] ..
      ident_char .. [[+]] .. [[%(\.]] .. ident_char .. [[+)*]] .. -- name
      [[%(\<.{-}\>)?]] .. -- generics
    [[)]] ..
    "|" ..
    [[\.ctor]] ..
    "|" ..
    [[\.cctor]] ..
  [[)]]

local method_params = [[\(%(]] .. class_name .. [[)?(,[ ]?]] .. class_name .. [[)*\)]]

local file_name = [[\(at.*\)]]

local stack_trace_entry =
  "^" ..
  class_name ..
  "%(" .. method_name .. ")" ..
  "%( " .. method_params .. ")?" ..
  "%( " .. file_name .. ")?" ..
  "$"

local stack_trace_entry_regexp = "\\v" .. stack_trace_entry

local stack_trace_regexp = "\\v" ..
  [[%(]] .. stack_trace_entry .. [[\n)@<!]] ..
  stack_trace_entry .. [[%(\n]] .. stack_trace_entry ..[[)*\n\n]]


function M.search_stack_trace_entry()
  vim.api.nvim_command("/" .. stack_trace_entry_regexp)
end

function M.search_stack_trace()
  vim.api.nvim_command("/" .. stack_trace_regexp)
end

function M.remove_stack_traces()
  vim.api.nvim_command(":%g/" .. stack_trace_entry_regexp .. "/d")
  -- NOTE: This would remove whole blocks, but is not cosistent.
  -- vim.api.nvim_command(":%s/" .. stack_trace_regexp .. "/---\r/")
end


vim.api.nvim_create_user_command("UnityLogSearchStackTraceEntry", function (_)
  M.search_stack_trace_entry()
end, {})

vim.api.nvim_create_user_command("UnityLogSearchStackTrace", function (_)
  M.search_stack_trace()
end, {})

vim.api.nvim_create_user_command("UnityLogRemoveStackTraces", function (_)
  M.remove_stack_traces()
end, {})

return M
