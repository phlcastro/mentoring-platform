require 'rails_helper'
require 'constraints/api_constraints'

describe ApiConstraints do
  let(:api_constraints_v1) { described_class.new(version: 1) }
  let(:api_constraints_v2) { described_class.new(version: 2, default: true) }

  describe '::matches?' do
    context 'when receives a valid parameter' do
      it 'returns true when the version matches the Accept header' do
        request = instance_double(ActionDispatch::Request,
                                  headers: { 'Accept' => 'application/mentoring-platform-v1' })
        expect(api_constraints_v1.matches?(request)).to be true
      end

      it 'returns the default version when default option is specified' do
        request = instance_double(ActionDispatch::Request, headers: { 'Accept' => '' })
        expect(api_constraints_v2.matches?(request)).to be true
      end
    end

    context 'when receives an invalid parameter' do
      it 'returns false when the version does not matche the Accept header' do
        request = instance_double(ActionDispatch::Request,
                                  headers: { 'Accept' => 'application/mentoring-platform-v3' })
        expect(api_constraints_v1.matches?(request)).to be false
      end
    end
  end
end
