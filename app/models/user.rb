class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true

  has_many :answers, dependent: :destroy
  has_many :follow_tags, dependent: :destroy

  # 追加メソッド
  # 全てのタグのフォロー状況を返す
  def return_follow_status_tags
    # タグの一覧を取得する
    hash = { '状態' => {}, '職種' => {} }
    status_tags = Tag.where(genre: '状態')
    status_tags.each do |tag|
      hash['状態'][tag.id] = {name: tag.name, status: false}
    end
    occupation_tags = Tag.where(genre: '職種')
    occupation_tags.each do |tag|
       hash['職種'][tag.id] = {name: tag.name, status: false}
    end
    # フォローしているタグのstatusをtrueに変更する
    follow_tags = FollowTag.where(user_id: self.id)
    follow_tags.each do |follow_tag|
      if hash['状態'].key?(follow_tag.tag_id)
        hash['状態'][follow_tag.tag_id][:status] = true
      elsif hash['職種'].key?(follow_tag.tag_id)
        hash['職種'][follow_tag.tag_id][:status] = true
      end
    end
    hash
  end

    # フォローしているタグをarray形式で返す
  def return_follow_tags_array
    array = []
    follow_tags = FollowTag.where(user_id: self.id).order(:tag_id)
    follow_tags.each do |follow_tag|
      array.push([follow_tag.tag.name, follow_tag.tag_id])
    end
    array
  end
end
