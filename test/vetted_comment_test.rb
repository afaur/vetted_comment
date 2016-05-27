require_relative 'test_helper'
require 'webmock/minitest'

WebMock.disable_net_connect!(allow_localhost: true)
ActiveSupport.test_order = :random

class VettedCommentTest < ActiveSupport::TestCase
  setup do
    positive_result = {:type => "positive"}
    negative_result = {:type => "negative"}

    # stub positive result
    stub_request(:post, "http://mashape/test/endpoint?text=You%20are%20amazing%20at%20life!").
    with(:headers => {'Accept'=>'application/json', 'Content-Type'=>'application/json', 'X-Mashape-Key'=>'testkey'}).
    to_return(:status => 200, :body => positive_result.to_json, :headers => {})

    # stub negative result
    stub_request(:post, "http://mashape/test/endpoint?text=You%20suck%20at%20life!").
    with(:headers => {'Accept'=>'application/json', 'Content-Type'=>'application/json', 'X-Mashape-Key'=>'testkey'}).
    to_return(:status => 200, :body => negative_result.to_json, :headers => {})
  end

  test "vetting a positive comment" do
    positive_result = VettedComment.vet_comment("You are amazing at life!")
    assert_equal "You are amazing at life!", positive_result.body
    assert_equal "positive", positive_result.tone
  end

  test "vetting a negative result" do
    negative_result = VettedComment.vet_comment("You suck at life!")
    assert_equal "You suck at life!", negative_result.body
    assert_equal "negative", negative_result.tone
  end
end