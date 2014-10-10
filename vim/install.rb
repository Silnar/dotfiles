#!/usr/bin/ruby

require 'fileutils'

script_dir = File.expand_path(File.dirname(__FILE__))
script_path = File.join(script_dir, "vimrc")

FileUtils.ln_sf(script_path, File.join(ENV["HOME"], ".vimrc"), :verbose => true)
