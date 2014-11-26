class AddDataToStat < ActiveRecord::Migration
  def change
    add_column :stats, :data, :text
  end
end
