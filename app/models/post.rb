class Post < ApplicationRecord
    belongs_to :user
    has_many :post_comments, dependent: :destroy
    
    validates :title, presence: true
    validates :body, presence: true
    
    include SimpleHashtag::Hashtaggable
      
    hashtaggable_attribute :body
    
    def self.search(search)
        where("title LIKE ?", "%#{search}%") 
    end
end
