class Question < ApplicationRecord
  with_options presence: true do
    validates :body
    validates :answer_count
  end

  has_many :answers, dependent: :destroy
  belongs_to :tag
end
