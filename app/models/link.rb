class Link < ApplicationRecord
    acts_as_votable
    belongs_to :user
    has_many :comments, :dependent => :delete_all
    
    def self.search(search)
    		where("title LIKE ?", "%#{search}%") 
  	end
   
    validates :title, :url, presence: true
    validates :url, format: { with: /https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&\/=]*)?/, message: "jest niewłaściwy" }
end
