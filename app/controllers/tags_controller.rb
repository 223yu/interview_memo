class TagsController < ApplicationController

  def index
    @tags_hash = current_user.return_follow_status_tags
  end

  def update
    tag = Tag.find(params[:id])
    if FollowTag.create(user_id: current_user.id, tag_id: tag.id)
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
