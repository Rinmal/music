class Message < ApplicationRecord
  belongs_to :user
  belongs_to :group

  with_options presence: true do
    validates :user_id
    validates :group_id
    validates :message
  end

end
