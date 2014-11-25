class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name, null: false
      t.integer :win
      t.integer :loss
      t.belongs_to :division, index: true

      t.timestamps
    end
    
    add_index :teams, :name, unique: true
  end
end
