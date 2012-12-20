#!/usr/bin/evn ruby
# coding: utf-8

require 'yaml'
require 'twitter'

Encoding.default_external = Encoding::UTF_8

BASE_PATH   = File.expand_path(File.dirname(__FILE__))
CONFIG_FILE = File.join(BASE_PATH, 'config.yml')

unless File.exist?(CONFIG_FILE)
  puts 'copy config.yml.sample to config.yml and set your keys'
  exit 1
end

config = YAML.load_file(CONFIG_FILE)

Twitter.configure do |c|
  c.consumer_key = config['twitter']['consumer_key']
  c.consumer_secret = config['twitter']['consumer_secret']
  c.oauth_token = config['twitter']['oauth_token']
  c.oauth_token_secret = config['twitter']['oauth_token_secret']
end

ICON_DEFAULT = File.join(BASE_PATH, 'images', 'default.png')
ICON_GREEN   = File.join(BASE_PATH, 'images', 'green.png')
ICON_RED     = File.join(BASE_PATH, 'images', 'red.png')

HASH_TAG = '#testingcode'
SCREEN_NAME = config['twitter']['screen_name']
THRESHOLD_HOUR = 36

testing_statuses =
  Twitter.search("from:#{SCREEN_NAME} #testingcode", result_type: 'recent').statuses

exit if testing_statuses.size == 0

last_status = testing_statuses.first

case(last_status.text)
when /^green /
  hour_past = (Time.now - last_status.created_at)/(60*60)
  if (hour_past > THRESHOLD_HOUR)
    Twitter.update("red #{Time.now} #{HASH_TAG}")
    Twitter.update_profile_image(File.new(ICON_RED))
  end
when /^red /
  # do nothing
else
  # `テスト書いた #testingcode`
  Twitter.update_profile_image(File.new(ICON_GREEN))
  Twitter.update("green #{Time.now} #{HASH_TAG}")
end