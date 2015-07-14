require 'rails_helper'

describe Option do
  it { should belong_to :question }
  it { should validate_presence_of :query }
  it { should have_many :votes }

  describe ".votes_user_ids" do
    it "will return an array of unique user ids for the votes of an option" do
      option = create(:option_with_votes)
      expect(option.votes_user_ids).to eql [2, 3, 4]
    end
  end
end
