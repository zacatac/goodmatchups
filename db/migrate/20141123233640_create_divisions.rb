class CreateDivisions < ActiveRecord::Migration
  def change
    create_table :divisions do |t|
      t.string :name, null: false

      t.timestamps
    end
    
    add_index :divisions, :name, unique: true
  end
end
