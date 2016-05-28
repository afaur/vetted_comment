require_relative 'support/helper'
require 'webmock/minitest'

WebMock.disable_net_connect!(allow_localhost: true)
ActiveSupport.test_order = :random

class CommentTest < ActiveSupport::TestCase
  setup do
    positive_result = {:type => "positive"}
    negative_result = {:type => "negative"}

    # stub positive result
    stub_request(:post, "http://mashape/test/endpoint?text=You%20are%20amazing%20at%20life!").
    with(:headers => {'Accept'=>'application/json', 'Content-Type'=>'application/json', 'X-Mashape-Key'=>'testkey'}).
    to_return(:status => 200, :body => positive_result.to_json, :headers => {'Content-Type'=>'application/json'})

    # stub negative result
    stub_request(:post, "http://mashape/test/endpoint?text=You%20suck%20at%20life!").
    with(:headers => {'Accept'=>'application/json', 'Content-Type'=>'application/json', 'X-Mashape-Key'=>'testkey'}).
    to_return(:status => 200, :body => negative_result.to_json, :headers => {'Content-Type'=>'application/json'})
  end

  test "creating a positive comment" do
    positive_comment = Comment.new(
      body: "You are amazing at life!"
    )
    positive_comment.save
    assert_equal "positive", positive_comment.tone
  end

  test "creating a negative result" do
    negative_comment = Comment.new(
      body: "You suck at life!"
    )
    negative_comment.save
    assert_equal "negative", negative_comment.tone
  end
end
