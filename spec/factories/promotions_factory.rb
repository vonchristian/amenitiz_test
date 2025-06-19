FactoryBot.define do
  factory :promotion do
    product { nil }
    rule_type { "Rules::BuyOneGetOne" }
    rule_id { "" }
    code { SecureRandom.hex(10) }
    name { "PR1" }
  end
end
