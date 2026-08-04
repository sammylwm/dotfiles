vim.api.nvim_create_user_command("Repl", function(opts)
  if not vim.bo.modifiable then
    print("Buffer is not modifiable")
    return
  end

  if #opts.fargs ~= 2 then
    print("Usage: :Repl old new")
    return
  end

  local old = opts.fargs[1]
  local new = opts.fargs[2]

  local range = opts.range == 0 and "%" or opts.line1 .. "," .. opts.line2

  vim.cmd(range .. "s/\\V" .. old .. "/" .. new .. "/g")
end, {
  nargs = "*",
  range = true,
})
