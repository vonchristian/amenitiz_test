class Promotion < ApplicationRecord
  belongs_to :product
  validates :code, presence: true, uniqueness: true
  validates :name, :rule_type, presence: true
end
