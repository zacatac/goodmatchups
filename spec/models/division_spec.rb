require 'rails_helper'

RSpec.describe Division, :type => :model do
  before do
    @division = Division.new(name: "Ben Franklin Labs")
  end
 
  subject { @division }
 
  describe "when name is not present" do
    before { @division.name = " " }
    it { should_not be_valid }
  end
end
