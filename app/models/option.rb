class Option < ActiveRecord::Base
  belongs_to :question
  has_many :votes, as: :votable, dependent: :destroy

  validates :query, presence: true

  def votes_user_ids
    ids = self.votes.collect { |vote| vote.user_id }
    ids.uniq
  end
end
