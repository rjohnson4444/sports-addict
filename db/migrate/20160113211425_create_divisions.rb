class CreateDivisions < ActiveRecord::Migration
  def change
    create_table :divisions do |t|
      t.string :name
      t.references :conference, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
