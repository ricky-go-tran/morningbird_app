FactoryBot.define do
  factory :credential_shopify do
    shop { "MyString" }
    scopes { "MyText" }
    access_token { "MyString" }
  end
end
