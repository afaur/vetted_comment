require 'httparty'

class VettedComment
  include HTTParty
  attr_accessor :body, :tone

  def initialize(opts={})
    self.body = opts[:body]
    self.tone = opts[:tone]
  end

  def self.vet_comment(body)
    key = "testkey"
    sentiment_uri = "http://mashape/test/endpoint"
    
    query = {'text' => body}

    headers = {}.tap do |h|
      h['X-Mashape-Key'] = key
      h['Content-Type'] = 'application/json'
      h['Accept'] = 'application/json'
    end

    res = HTTParty.post(sentiment_uri, :query => query, :headers => headers)
    
    self.new(body: body, tone: res['type'])
  end
end