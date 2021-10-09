class QuestionTag < ApplicationRecord
  with_options presence: true do
    validates :question_id
    validates :tag_id
  end
  
  belongs_to :question
  belongs_to :tag
end
