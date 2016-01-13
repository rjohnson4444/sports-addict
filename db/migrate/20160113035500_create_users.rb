class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :profile_image
      t.string :description
      t.string :uid
      t.string :favorite_team
      t.string :oauth_token
      t.string :oauth_secret

      t.timestamps null: false
    end
  end
end
