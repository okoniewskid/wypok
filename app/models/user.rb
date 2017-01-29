class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  has_many :links, :dependent => :delete_all
  has_many :posts, :dependent => :delete_all
  has_many :comments, :dependent => :delete_all
  
  validates :name, presence: true, :uniqueness => true
  validates :email, presence: true, :uniqueness => true
  
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/assets/default_avatar.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  
  after_create :assign_default_role

  def assign_default_role
    if self == User.first
      self.add_role(:admin) if self.roles.blank?
    end
    self.add_role(:email) if self.roles.blank?
  end
  
  def update_with_password(params={}) 
    if params[:password].blank? 
      params.delete(:password) 
      params.delete(:password_confirmation) if params[:password_confirmation].blank? 
    end 
    update_attributes(params) 
  end
  
  def self.search(search)
      where("name LIKE ?", "%#{search}%") 
  end
end
