require 'rails_helper'

RSpec.describe Question, type: :model do
  subject { question }

  let(:question) { FactoryGirl.build(:question) }

  it { is_expected.to respond_to(:from_user) }
  it { is_expected.to respond_to(:to_user) }
  it { is_expected.to respond_to(:description) }
  it { is_expected.to respond_to(:status) }
  it { is_expected.to validate_presence_of(:from_user_id) }
  it { is_expected.to validate_presence_of(:to_user_id) }
  it { is_expected.to validate_presence_of(:description) }

  it { is_expected.to be_valid }
end
