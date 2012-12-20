# coding: utf-8
require 'testing_code_bot'
require 'yaml'

describe TestingCodeBot do
  context 'initialize' do
    it 'should receive config' do
      BASE_PATH   = File.expand_path(File.dirname(__FILE__))

      config = YAML.load_file(File.join(BASE_PATH, '..', 'config.yml.sample'))
      config['base_path'] = BASE_PATH

      bot = TestingCodeBot.new(config)
      bot.screen_name.should == 'YOUR_NAME'
    end
  end
end