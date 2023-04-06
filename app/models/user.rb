class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image

  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :groups, through: :entries
  has_many :messages, dependent: :destroy
  has_many :favorite_posts, through: :favorites, source: :post

  # フォローするユーザー
  has_many :relationships, foreign_key: :following_id
  has_many :followings, through: :relationships, source: :follower

  # フォローされるユーザー
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: :follower_id
  has_many :followers, through: :reverse_of_relationships, source: :following

  validates :name, length: {minimum: 2, maximum: 20 },uniqueness: true
  validates :introduction, length: {maximum: 50 }

  def get_profile_image
    unless profile_image.attached?
     file_path = Rails.root.join('app/assets/images/white.jpg')
     profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize: "150x150^", gravity: "center", crop: "100x100+0+0").processed
  end

# ゲストログイン機能
  def self.guest
    find_or_create_by!(name: 'ゲストユーザー', email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.email = "guest@example.com"
    end
  end

  def is_followed_by?(user)
    reverse_of_relationships.find_by(following_id: user.id).present?
  end

end
