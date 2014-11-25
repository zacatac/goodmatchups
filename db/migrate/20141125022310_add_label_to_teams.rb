class AddLabelToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :label, :string
  end
end
