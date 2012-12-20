# coding: utf-8
require 'testing_status'

describe TestingStatus do
  context 'initialize' do
    it 'is red tweet' do
      status = TestingStatus.new('#testingcode', text: 'red 2012-12-20 21:05:20 +0900 #testingcode')
      status.color.should == :red
    end

    it 'is green tweet' do
      status = TestingStatus.new('#testingcode', text: 'green 2012-12-20 21:05:20 +0900 #testingcode')
      status.color.should == :green
    end

    it 'is gray tweet' do
      status = TestingStatus.new('#testingcode', text: '書いた #testingcode')
      status.color.should == :gray
    end

    it 'is not testing tweet' do
      status = TestingStatus.new('#testingcode', text: 'hogehoge')
      status.color.should == nil
    end
  end

  context 'next color' do
    it 'should change to green (last test: now)' do
      status = TestingStatus.new('#testingcode', text: 'テスト書いた #testingcode', created_at: (Time.now))
      status.next_color.should == :green
    end

    it 'should change to red (last test: 2 days ago)' do
      status = TestingStatus.new('#testingcode', text: 'green 20**-12-20 21:05:20 +0900 #testingcode', created_at: (Time.now - 2*24*60*60))
      status.next_color.should == :red
    end
  end
end