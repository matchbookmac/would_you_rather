class Question < ActiveRecord::Base
  belongs_to :user
  has_many :options

  accepts_nested_attributes_for :options, allow_destroy: true
end
