class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :email
      t.string :name
      t.string :avatar
      t.string :phone
      t.boolean :friend

      t.timestamps
    end
  end
end
