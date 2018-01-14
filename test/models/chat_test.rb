require 'test_helper'

class ChatTest < ActiveSupport::TestCase
   test "the truth" do
     chat = Chat.new
     assert_not chat.save, "Saved the post without a title"
   end
end
