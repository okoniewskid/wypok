class PostComment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  
  validates :post_id, presence: true
  validates :body, presence: true
  
  include SimpleHashtag::Hashtaggable
      
  hashtaggable_attribute :body
end
