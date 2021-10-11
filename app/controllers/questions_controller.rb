class QuestionsController < ApplicationController

  def index
    if params[:follow_tag_ids]
      @follow_tags = FollowTag.return_follow_tags_index(params[:follow_tag_ids])
    else
      @follow_tags = FollowTag.where(user_id: current_user.id).order(:tag_id)
    end
    @questions = Question.return_unanswered_questions(current_user, @follow_tags)
  end

  def new
    @question = Question.new
    @follow_tags = current_user.return_follow_tags_array
  end

  def create
    @question = Question.new(question_params)
    @question.save
  end

  private

  def question_params
    params.require(:question).permit(:tag_id, :body)
  end
end
