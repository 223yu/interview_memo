class Answer < ApplicationRecord
  with_options presence: true do
    validates :user_id
    validates :question_id
    validates :body
  end
  
  belongs_to :user
  belongs_to :question
end
