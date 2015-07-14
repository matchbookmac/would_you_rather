require 'rails_helper'

describe Option do
  it { should belong_to :question }
  it { should validate_presence_of :query }
  it { should have_many :votes }

  describe ".votes_user_ids" do
    it "will return an array of unique user ids for the votes of an option" do
      option = create :option_with_votes
      user = option.votes.first.user
      option.votes.new(user_id: user.id)
      expect(option.votes_user_ids.length).to eql 3
    end
  end
end
