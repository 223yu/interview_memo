class FollowTag < ApplicationRecord
  with_options presence: true do
    validates :user_id
    validates :tag_id
  end
  
  belongs_to :user
  belongs_to :tag
end
