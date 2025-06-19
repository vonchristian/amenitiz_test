require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:code) }
  end

  describe 'associations' do
    it { should have_many(:prices).dependent(:destroy) }
  end
end
