class Link < ApplicationRecord
    acts_as_votable
    belongs_to :user
    has_many :comments, :dependent => :delete_all
    
    validates :title, :url, presence: true
    validates :url, format: { with: /((http[s]?|ftp):\/)?\/?([^:\/\s]+)((\/\w+)*\/)([\w\-\.]+[^#?\s]+)(.*)?(#[\w\-]+)?/, message: "jest niewłaściwy" }
end
