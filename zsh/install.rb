#!/usr/bin/ruby

script_dir = File.expand_path(File.dirname(__FILE__))

contents = <<EOF
export ZDOTDIR="#{script_dir}"

if [ -f ~/.env ]
then
  source ~/.env
fi

EOF

File.open(File.join(ENV["HOME"], ".zshenv"), 'w') do |f|
  f.write(contents)
end
