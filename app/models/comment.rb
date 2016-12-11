class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :link
  
  validates :link_id, presence: true
  validates :body, presence: true
  
  include SimpleHashtag::Hashtaggable
  
  hashtaggable_attribute :body
end
