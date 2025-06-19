class Promotion < ApplicationRecord
  belongs_to :product
  belongs_to :rule, polymorphic: true, optional: true
  validates :code, presence: true, uniqueness: true
  validates :name, :rule_type, presence: true

  def resolved_rule
    rule.presence || rule_type.safe_constantize&.new
  end
end
