class Question < ApplicationRecord
  with_options presence: true do
    validates :body
    validates :answer_count
  end

  has_many :answers, dependent: :destroy
  belongs_to :tag

  # 追加メソッド
  # ユーザが未回答の質問一覧を回答数順に返す
  def self.return_unanswered_questions(user, follow_tags)
    all_questions = Question.none
    follow_tags.each do |follow_tag|
      all_questions += Question.joins(:tag).where(tag_id: follow_tag.tag.id)
    end
    answered_questions = Question.joins(:answers).where(answers: { user_id: user.id })
    unanswerd_questions = all_questions - answered_questions
    unanswerd_questions.sort{|a,b| b.answer_count <=> a.answer_count}
  end

  # ユーザが回答済の質問一覧を回答数順に配列形式で返す[[回答id, タグ名, 質問内容, 回答内容, 回答数], []...[]]
  def self.return_answered_questions(user, follow_tags)
    answered_questions = Question.none
    follow_tags.each do |follow_tag|
      answered_questions += Question.joins(:answers, :tag).where(tag_id: follow_tag.tag_id, answers: { user_id: user.id} ).pluck('answers.id, tags.name, questions.body, answers.body, questions.answer_count')
    end
    answered_questions.sort{ |a,b| b[4] <=> a[4]}
  end
end
