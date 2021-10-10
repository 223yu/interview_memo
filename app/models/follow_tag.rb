class FollowTag < ApplicationRecord
  with_options presence: true do
    validates :user_id
    validates :tag_id
  end

  belongs_to :user
  belongs_to :tag

  # 追加メソッド
  # idの配列からフォロータグの一覧を返す
  def self.return_follow_tags_index(array)
    follow_tags = FollowTag.none
    array.each do |n|
      follow_tags += FollowTag.where(id: n.to_i)
    end
    follow_tags
  end
end
