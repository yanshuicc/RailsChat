class Messages_read_flag < ActiveRecord::Base
  belongs_to :user
  belongs_to :message


  sync :all
end
