require 'rails_helper'

RSpec.describe Answer, type: :model do
  subject { answer }

  let(:answer) do
    user = FactoryGirl.build(:user)
    FactoryGirl.build(:answer, user: user)
  end

  it { is_expected.to respond_to(:user) }
  it { is_expected.to respond_to(:question) }
  it { is_expected.to respond_to(:description) }
  it { is_expected.to validate_presence_of(:user) }
  it { is_expected.to validate_presence_of(:question) }
  it { is_expected.to validate_presence_of(:description) }

  it { is_expected.to be_valid }
end
