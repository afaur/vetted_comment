require 'pry'
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end

class Comment < ApplicationRecord

  validates_presence_of :body
  after_save :vet_comment

  def vet_comment
    vetted_comment = VettedComment.vet_comment(self.body)
    #binding.pry
    self.update_attribute(:tone, vetted_comment.tone)
  end
end

