class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :access_key
      t.string :password_digest
      t.string :email
      t.timestamps
    end
  end
end
