require 'rails_helper'

describe Comment do
  it { should validate_presence_of :text }
  it { should belong_to :post }
end
