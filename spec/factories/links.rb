FactoryGirl.define do
  factory :link do
    title 'The amazing link title'
    url 'https://ide.c9.io'
  end
  
  factory :user do
    name 'Username'
    email 'user@mail.com'
    password 'password12'
    password_confirmation 'password12'
    remember_me true
  end
end