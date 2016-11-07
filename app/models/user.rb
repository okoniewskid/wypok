class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  has_many :links, :dependent => :delete_all
  has_many :comments, :dependent => :delete_all
  
  validates :name, presence: true, :uniqueness => true
  validates :email, presence: true, :uniqueness => true
end
