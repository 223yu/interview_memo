class Answer < ApplicationRecord
  with_options presence: true do
    validates :user_id
    validates :question_id
    validates :body
  end

  belongs_to :user
  belongs_to :question

  # 追加メソッド
  # 回答を保存し、回答数を1増やす
  def save_and_increase_answer_count
    is_true = true
    Answer.transaction(joinable: false, requires_new: true) do
      is_true &= self.save
      question = Question.find(question_id)
      is_true &= question.update(answer_count: question.answer_count + 1)

      unless is_true
        raise ActiveRecord::Rollback
      end
    end
    is_true
  end
end
