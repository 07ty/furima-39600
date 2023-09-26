require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
  @item = FactoryBot.build(:item)
end

  describe '出品' do
    context '正常形' do
    it '全ての項目が入力されていれば出品できる' do
    expect(@item).to be_valid
    end
  end
    context '異常形' do
    it 'イメージ画像が空では出品できない' do
    @item.image = nil
    @item.valid?
    expect(@item.errors.full_messages).to include("Image can't be blank")
    end
    it '商品名が空では出品できない' do
    @item.item = ''
    @item.valid?
    expect(@item.errors.full_messages).to include("Item can't be blank")
    end
    it '商品の説明が空では出品できない' do
    @item.description = ''
    @item.valid?
    expect(@item.errors.full_messages).to include("Description can't be blank")
    end
    it 'カテゴリーが未選択では出品できない' do
    @item.category_id = '1'
    @item.valid?
    expect(@item.errors.full_messages).to include("Category can't be blank")
    end
    it '商品の状態が未選択では出品できない' do
    @item.condition_id = '1'
    @item.valid?
    expect(@item.errors.full_messages).to include("Condition can't be blank")
    end
    it '送料負担が未選択では出品できない' do
    @item.shipping_charge_id = '1'
    @item.valid?
    expect(@item.errors.full_messages).to include("Shipping charge can't be blank")
    end
    it '配送地域が未選択では出品できない' do
    @item.prefecture_id = '1'
    @item.valid?
    expect(@item.errors.full_messages).to include("Prefecture can't be blank")
    end
    it 'お届け予定日が未選択では出品できない' do
    @item.delivery_date_id = '1'
    @item.valid?
    expect(@item.errors.full_messages).to include("Delivery date can't be blank")
    end
    it '販売価格が空では出品できない' do
    @item.price = ''
    @item.valid?
    expect(@item.errors.full_messages).to include("Price can't be blank")
    end
    it '販売価格が300円以下では出品できない' do
    @item.price = '299'
    @item.valid?
    expect(@item.errors.full_messages).to include("Price must be greater than or equal to 300")
    end
    it '販売価格がが1000万円以上では出品できない' do
    @item.price = '10000000'
    @item.valid?
    expect(@item.errors.full_messages).to include("Price must be less than or equal to 9999999")
    end
    it '販売価格がが全角の数字では出品できない' do
    @item.price = '１２３４'
    @item.valid?
    expect(@item.errors.full_messages).to include("Price is not a number")
    end
    it '販売価格がが整数でなければ出品できない' do
    @item.price = '123.01'
    @item.valid?
    expect(@item.errors.full_messages).to include("Price is out of setting range")
    end
    it 'ユーザーが紐付いていないと保存できない' do
      item = FactoryBot.build(:item, user: nil)
      item.valid?
      expect(item.errors.full_messages).to include("User must exist")
    end    
  end
end
end