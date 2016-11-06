class Link < ApplicationRecord
    acts_as_votable
    belongs_to :user
    has_many :comments, :dependent => :delete_all
   
    validates :title, :url, presence: true
    validates :url, format: { with: /https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&\/=]*)?/, message: "jest niewłaściwy" }
    
        
    def self.search(search)
        where("title LIKE ?", "%#{search}%") 
    end
    
    def ci_lower_bound(pos, n, confidence)
        if n == 0
            return 0.0
        end
        z = Statistics2.pnormaldist(1-(1-confidence)/2)
        phat = 1.0*pos/n
        ((phat + z*z/(2*n) - z * Math.sqrt((phat*(1-phat)+z*z/(4*n))/n))/(1+z*z/n)*100).round(2)
    end
    
    def generate_image(link)
        begin
          @object = LinkThumbnailer.generate(link.url) 
          @e = false
          rescue
            @e = true
        end
        if !@e && @object.images && @object.images.first
            @object.images.first.src.to_s
        else
            "/assets/brakzdjec_sapeppe.gif"
        end
    end
end
