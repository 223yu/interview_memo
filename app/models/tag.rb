class Tag < ApplicationRecord
  enum genre: {
    '一般': 0, '状態': 1, '職種': 2
  }
  
  with_options presence: true do
    validates :name
    validates :genre
  end
  
  has_many :question_tags, dependent: :destroy
  has_many :follow_tags, dependent: :destroy
end
