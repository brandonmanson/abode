class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.string :email
      t.integer :dwelling_id
      t.timestamps
    end
  end
end
