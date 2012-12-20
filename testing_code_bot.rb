#!/usr/bin/env ruby
# coding: utf-8

require './lib/testing_code_bot'
require './lib/testing_status'
require 'yaml'

Encoding.default_external = Encoding::UTF_8

BASE_PATH   = File.expand_path(File.dirname(__FILE__))
CONFIG_FILE = File.join(BASE_PATH, 'config.yml')

unless File.exist?(CONFIG_FILE)
  puts 'copy config.yml.sample to config.yml and set your keys'
  exit 1
end

config = YAML.load_file(CONFIG_FILE)
config['base_path'] = BASE_PATH

bot = TestingCodeBot.new(config)
status = bot.last_testing_status
exit unless status

testing_status = TestingStatus.new(bot.hash_tag, status)
next_color = testing_status.next_color
exit unless next_color

bot.update_status(next_color)
bot.update_icon_color(next_color)
