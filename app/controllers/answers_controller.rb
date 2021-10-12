class AnswersController < ApplicationController

  def index
    if params[:follow_tag_ids]
      @follow_tags = FollowTag.return_follow_tags_index(params[:follow_tag_ids])
    else
      @follow_tags = FollowTag.where(user_id: current_user.id).order(:tag_id)
    end
    @questions = Question.return_answered_questions(current_user, @follow_tags)
    respond_to do |format|
      format.html
      format.js { render 'questions/index.js.erb' }
    end
  end

  def create
    @question_id = params[:question_id]
    answer_body = params[:answer_body]
    @answer = Answer.new(user_id: current_user.id, question_id: @question_id, body: answer_body)
    unless @answer.save_and_increase_answer_count
      flash.now[:danger] = '問題が発生しました。画面をリロードしてください。'
    end
  end

  def update
    answer_body = params[:answer_body]
    @answer = Answer.find(params[:id])
    if @answer.update(body: answer_body)
      flash.now[:success] = '回答を更新しました。'
    end
  end

  def destroy
    @answer = Answer.find(params[:id])
    if @answer.destroy_and_decrease_answer_count
      flash.now[:success] = '回答を削除しました。'
    else
      flash.now[:danger] = '問題が発生しました。画面をリロードしてください。'
    end
  end
end
