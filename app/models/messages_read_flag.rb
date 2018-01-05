class Messages_read_flag < ActiveRecord::Base
  belongs_to :user
  belongs_to :message


  sync :all
  sync_scope :by_user, ->(user) { where(user_id: user.id) }
end
