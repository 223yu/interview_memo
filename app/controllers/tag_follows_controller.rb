class TagFollowsController < ApplicationController

  def create
    tag = Tag.find(params[:tag_id])
    follow_tag = FollowTag.new(user_id: current_user.id, tag_id: tag.id)
    if follow_tag.save
      flash.now[:success] = "#{tag.name}をフォローしました。"
    else
      flash.now[:danger] = '問題が発生しました。画面をリロードしてください。'
    end
    respond_to do |format|
      format.js { render 'flash.js.erb' }
    end
  end

  def destroy
    tag = Tag.find(params[:id])
    follow_tag = FollowTag.find_by(user_id: current_user.id, tag_id: tag.id)
    if follow_tag.destroy
      flash.now[:success] = "#{tag.name}のフォローを解除しました"
    else
      flash.now[:danger] = '問題が発生しました。画面をリロードしてください。'
    end
    respond_to do |format|
      format.js { render 'flash.js.erb' }
    end
  end
end
