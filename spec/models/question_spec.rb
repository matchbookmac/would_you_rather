require 'rails_helper'

describe Question do
  it { should belong_to :user }
  it { should have_many :options }
  it { should have_many :votes }
end
