class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :taggings
  has_many :tags, through: :taggings

  validates :body, presence: true, length: {maximum: 100}

  # DBに入る前に実行
  after_create do
    post = Post.find_by(id: self.id)
    tags = self.body.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    # タグの先頭の＃を外して保存
    tags.uniq.map do |tag|
      tag = Tag.find_or_create_by(body: tag.downcase.delete('#'))
      post.tags << tag
    end
  end

  def self.search(search)
    if search != nil
      Post.where('body LIKE(?)' , "%#{search}%")
    else
      Post.all
    end
  end

  def favorited_by?(user)
    self.favorites.exists?(user_id: user.id)
  end

end
