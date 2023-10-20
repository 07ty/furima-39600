require 'rails_helper'
RSpec.describe PurchaseRecordAddress, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @purchase_record_address = FactoryBot.build(:purchase_record_address, user_id: user.id, item_id: item.id)
  end
  
  describe '購入' do
    context '正常形' do
      it '必要な情報を適切に入力すると、商品の購入ができる' do
        expect(@purchase_record_address).to be_valid
      end
      it '建物名は空でも購入できる' do
        @purchase_record_address.building_name = nil
        expect(@purchase_record_address).to be_valid
      end
    end
    
    context '異常形' do
      it '郵便番号が空では購入できない' do
        @purchase_record_address.post_code = ''
        @purchase_record_address.valid?
        expect(@purchase_record_address.errors.full_messages).to include("Post code can't be blank")
      end
      it '郵便番号「3桁ハイフン4桁」でなければ購入できない' do
        @purchase_record_address.post_code = '2343-345'
        @purchase_record_address.valid?
        expect(@purchase_record_address.errors.full_messages).to include("Post code is invalid")
      end
      it '郵便番号が半角でなければ購入できない' do
        @purchase_record_address.post_code = '９８４−００００'
        @purchase_record_address.valid?
        expect(@purchase_record_address.errors.full_messages).to include("Post code is invalid")
      end
      it '都道府県が空では購入できない' do
        @purchase_record_address.prefecture_id = ''
        @purchase_record_address.valid?
        expect(@purchase_record_address.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '都道府県に「---」が選択されている場合は購入できない' do
        @purchase_record_address.prefecture_id = '1'
        @purchase_record_address.valid?
        expect(@purchase_record_address.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '市区町村が空では購入できない' do
        @purchase_record_address.municipality = ''
        @purchase_record_address.valid?
        expect(@purchase_record_address.errors.full_messages).to include("Municipality can't be blank")
      end
      it '番地が空では購入できない' do
        @purchase_record_address.street_address = ''
        @purchase_record_address.valid?
        expect(@purchase_record_address.errors.full_messages).to include("Street address can't be blank")
      end
      it '電話番号が空では購入できない' do
        @purchase_record_address.telephone_number = ''
        @purchase_record_address.valid?
        expect(@purchase_record_address.errors.full_messages).to include("Telephone number can't be blank")
      end
      it '電話番号が10-11桁でなければ購入できない(12桁)' do
        @purchase_record_address.telephone_number = '090123456789'
        @purchase_record_address.valid?
        expect(@purchase_record_address.errors.full_messages).to include("Telephone number is too long (maximum is 11 characters)")
      end
      it '電話番号が10-11桁でなければ購入できない(9桁)' do
        @purchase_record_address.telephone_number = '090123456'
        @purchase_record_address.valid?
        expect(@purchase_record_address.errors.full_messages).to include("Telephone number is too short (minimum is 10 characters)")
      end
      it '電話番号が半角数字でなければ購入できない' do
        @purchase_record_address.telephone_number = '０９０１２３４５６７８'
        @purchase_record_address.valid?
        expect(@purchase_record_address.errors.full_messages).to include("Telephone number is not a number")
      end
      it "tokenが空では登録できないこと" do
        @purchase_record_address.token = nil
        @purchase_record_address.valid?
        expect(@purchase_record_address.errors.full_messages).to include("Token can't be blank")
      end
      it "userが紐付いていなければ購入できない" do
        item = FactoryBot.create(:item)
        usernil = FactoryBot.build(:purchase_record_address, item_id: item.id)
        usernil.valid?
        expect(usernil.errors.full_messages).to include("User can't be blank")
      end
      it "itemが紐付いていなければ購入できない" do
        user = FactoryBot.create(:user)
        itemnil= FactoryBot.build(:purchase_record_address, user_id: user.id)
        itemnil.valid?
        expect(itemnil.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end