require 'rails_helper'

RSpec.describe Price, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:amount_cents) }
    it { should validate_presence_of(:amount_currency) }
  end
  describe 'associations' do
    it { should belong_to(:product) }
  end
end
