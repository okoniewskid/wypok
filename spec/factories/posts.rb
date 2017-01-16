FactoryGirl.define do
  factory :post do
    title 'The amazing post title'
    body 'This is body of amazing post'
  end
  
  factory :invalid_post do
     title nil
     body nil
  end
end