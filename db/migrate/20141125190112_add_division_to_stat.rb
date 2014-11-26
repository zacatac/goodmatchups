class AddDivisionToStat < ActiveRecord::Migration
  def change
    add_reference :stats, :division, index: true
  end
end
