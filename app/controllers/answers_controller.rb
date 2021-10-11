class AnswersController < ApplicationController

  def index
  end

  def edit
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
  end

  def destroy
  end
  
  private
  
  def answer_params
    params.require(:answer).permit(:question_id, :body)
  end
end
