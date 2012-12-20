# coding: utf-8
require 'twitter'

class TestingCodeBot
  def initialize(config)
    @config = config
    @screen_name = @config['screen_name']
    @hash_tag = @config['hash_tag']


    initialize_twitter(@config)
  end

  attr_reader :screen_name, :hash_tag

  def initialize_twitter(config)
    Twitter.configure do |c|
      c.consumer_key = config['consumer_key']
      c.consumer_secret = config['consumer_secret']
      c.oauth_token = config['oauth_token']
      c.oauth_token_secret = config['oauth_token_secret']
    end
  end

  def update_icon_color(color)
    imagefile = "#{@config['base_path']}/images/#{color.to_s}.png"
    Twitter.update_profile_image(File.new(imagefile))
  end

  def update_status(color)
    Twitter.update("#{color.to_s} #{Time.now} #{@hash_tag}")
  end

  def last_testing_status
    Twitter.search("from:#{@screen_name} #{@hash_tag}", result_type: 'recent')
      .statuses
      .first
  end
end
