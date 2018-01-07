class CreateMessagesReadFlags < ActiveRecord::Migration[5.1]
  def change
    create_table :messages_read_flags do |t|
      t.integer :flag
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :message, index: true, foreign_key: true

      t.timestamps
    end
  end



end
