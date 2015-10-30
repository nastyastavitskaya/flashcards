require 'rails_helper'

describe Category do

  it { should have_many(:cards) }
  it { should belong_to(:user) }
end
