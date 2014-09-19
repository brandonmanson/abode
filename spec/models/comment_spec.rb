require 'rails_helper'

describe Comment do
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:type) }
  it { should validate_presence_of(:commentable_id) }
  it { should validate_presence_of(:description) }
  it { should validate_numericality_of(:user_id) }
  it { should validate_numericality_of(:commentable_id) }
  it do
    should validate_inclusion_of(:type).
      in_array(%w(dwelling expense))
  end
end
