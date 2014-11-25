class AddLabelToDivisions < ActiveRecord::Migration
  def change
    add_column :divisions, :label, :string
  end
end
