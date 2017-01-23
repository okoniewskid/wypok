FactoryGirl.define do
  factory :link do
    title 'The amazing link title'
    url 'https://ide.c9.io'
  end
  
  factory :user do
    name 'User'
    email 'user@mail.com'
    password 'password12'
  end
end