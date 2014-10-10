#!/usr/bin/ruby

puts "user.name: "
user_name = gets.chomp

puts "user.email: "
user_email = gets.chomp

script_dir = File.expand_path(File.dirname(__FILE__))
script_path = File.join(script_dir, "gitconfig")

git_config = <<EOF
[user]
	name = #{user_name}
	email = #{user_email}
[include]
  path = #{script_path}
EOF

File.open(File.join(ENV["HOME"], ".gitconfig"), 'w') do |f|
  f.write(git_config)
end

