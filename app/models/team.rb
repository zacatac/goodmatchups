class Team < ActiveRecord::Base
  belongs_to :division

  scope :in_division, lambda { |division|
    Team.joins(:division).where(:division_id => division.id)
  }

end
