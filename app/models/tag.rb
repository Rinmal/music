class Tag < ApplicationRecord

  has_many :taggings
  has_many :posts, through: :taggings

  validates :body, presence: true, length: {maximum: 50 }

# 先頭の＃を外して検索する
  def self.search(word)
    if word != '#'
      search = word.delete('#')
      tag = Tag.where('body LIKE(?)' , "%#{search}%")
      if tag.exists?
        tag[0].posts
      else
        Post.where('body LIKE(?)' , "%#{search}%")
      end
    else
      Post.all
    end
  end

end
