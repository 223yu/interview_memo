class QuestionsController < ApplicationController

  def index
    if params[:follow_tag_ids]
      @follow_tags = FollowTag.return_follow_tags_index(params[:follow_tag_ids])
    else
      @follow_tags = FollowTag.where(user_id: current_user.id)
    end
    @questions = Question.return_unanswered_questions(current_user, @follow_tags)
  end

  def new
  end

  def create
  end
end
