class Link < ApplicationRecord
    acts_as_votable
    belongs_to :user
    has_many :comments, :dependent => :delete_all
end
