class PostComment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  
  include SimpleHashtag::Hashtaggable
      
  hashtaggable_attribute :body
end
