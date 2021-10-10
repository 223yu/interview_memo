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
  end

  def destroy
  end
end
