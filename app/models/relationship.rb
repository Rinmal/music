class Relationship < ApplicationRecord
  # フォローするユーザー
  belongs_to :following, class_name: 'User'
  # フォローされるユーザー
  belongs_to :follower, class_name: 'User'
end
