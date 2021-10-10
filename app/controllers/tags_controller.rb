class TagsController < ApplicationController
  
  def index
    @tags_hash = current_user.return_follow_status_tags
  end
  
  def update
  end
  
  def destroy
  end
end
