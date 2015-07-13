class Option < ActiveRecord::Base
  belongs_to :question

  validates :query, presence: true
end
