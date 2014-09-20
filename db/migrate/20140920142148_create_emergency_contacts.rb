class CreateEmergencyContacts < ActiveRecord::Migration
  def change
    create_table :emergency_contacts do |t|
      t.string :name, :phone, :email, :relationship
      t.integer :user_id

      t.timestamps
    end
  end
end
