class Promotion < ApplicationRecord
  belongs_to :product
  belongs_to :rule, polymorphic: true, optional: true
  validates :code, presence: true, uniqueness: true
  validates :name, :rule_type, presence: true
end
