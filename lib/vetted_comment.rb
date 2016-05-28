require 'httparty'
require 'active_model'

MASHAPE = {
  sentiment: {
    key: "testkey",
    uri: "http://mashape/test/endpoint"
  }
}

class VettedComment
  VERSION = "0.0.1"

  include HTTParty
  include ActiveModel::Model
  include ActiveModel::Serialization
  include ActiveModel::Validations
  attr_accessor :body, :tone

  @@key = MASHAPE[:sentiment][:key]
  @@sentiment_uri = MASHAPE[:sentiment][:uri]

  def initialize(opts={})
    self.body = opts[:body]
    self.tone = opts[:tone]
  end

  def self.vet_comment(body)
    query = {'text' => body}

    headers = {}.tap do |h|
      h['X-Mashape-Key'] = @@key
      h['Content-Type'] = 'application/json'
      h['Accept'] = 'application/json'
    end

    res = HTTParty.post(@@sentiment_uri, :query => query, :headers => headers)
    self.new(body: body, tone: res['type'])
  end
end

