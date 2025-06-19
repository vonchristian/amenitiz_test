require 'rails_helper'

RSpec.describe Promotion, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:code) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:rule_type) }
  end

  describe 'associations' do
    it { should belong_to(:product) }
  end
end
