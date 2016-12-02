class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :link
  
  include SimpleHashtag::Hashtaggable
  
  hashtaggable_attribute :body
end
