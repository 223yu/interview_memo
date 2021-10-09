class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates :name, presence: true
  
  has_many :answers, dependent: :destroy
  has_many :follow_tags, dependent: :destroy
end
