require 'rails_helper'

describe Option do
  it { should belong_to :question }
  it { should validate_presence_of :query }
end
