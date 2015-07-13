class Question < ActiveRecord::Base
  belongs_to :user
  has_many :options
  has_many :votes, as: :votable

  accepts_nested_attributes_for :options, allow_destroy: true
end
