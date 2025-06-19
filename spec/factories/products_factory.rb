FactoryBot.define do
  factory :product do
    name { "MyString" }
    code { SecureRandom.hex(10) }
  end
end
