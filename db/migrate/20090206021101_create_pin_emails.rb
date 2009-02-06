class CreatePinEmails < ActiveRecord::Migration
  def self.up
    create_table :pin_emails do |t|
      t.integer :pin_id, :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :pin_emails
  end
end
