class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.text :provider
      t.integer :uid
      t.text :name
      t.text :token
      t.text :secret 
      t.timestamps
    end
  end
end
