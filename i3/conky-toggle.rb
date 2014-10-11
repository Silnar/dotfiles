#!/usr/bin/ruby

pid = `pgrep conky`
pid.chomp!

if $?.success?
  exec "kill #{pid}"
else
  exec "conky -d"
end
