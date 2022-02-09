FactoryBot.define do
  factory :inquiry do
    name { 'MyString' }
    name_kana { 'MyString' }
    email { 'MyString' }
    content { 'MyText' }
    remote_ip { '' }
  end
end
