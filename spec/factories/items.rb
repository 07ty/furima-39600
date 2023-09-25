FactoryBot.define do
    factory :item do
      item {'商品名'}
      description {'商品の説明'}
      category_id {'2'}
      condition_id {'2'}
      shipping_charge_id {'2'}
      prefecture_id {'2'}
      delivery_date_id {'2'}
      price {'300'}
      
      association :user
      after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.jpg'), filename: 'test_image.jpg')
      end
  end
end