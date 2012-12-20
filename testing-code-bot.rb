#!/usr/bin/evn ruby

require 'yaml'

Encoding.default_external = Encoding::UTF_8

BASE_PATH   = File.expand_path(File.dirname(__FILE__))
CONFIG_FILE = File.join(BASE_PATH, 'config.yml')

unless File.exist?(CONFIG_FILE)
  puts 'copy config.yml.sample to config.yml and set your keys'
  exit 1
end

config = YAML.load_file(CONFIG_FILE)

