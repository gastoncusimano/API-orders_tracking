require 'rails_helper'

RSpec.describe Shipment, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:tracking_reference) }
    it { should validate_presence_of(:courier) }
    it { should validate_inclusion_of(:courier).in_array(%w[fedex])}
  end
end
