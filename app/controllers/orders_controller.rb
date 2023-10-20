class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_items, only: [:index, :create]

  def index
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    @purchase_record_address = PurchaseRecordAddress.new

    @purchase_records = PurchaseRecord.where(item_id: @item.id)
    if current_user == @item.user
      redirect_to root_path
    elsif @purchase_records.present? && @purchase_records.pluck(:item_id).include?(@item.id) 
      redirect_to root_path
    end
  end

  def create
    @purchase_record_address = PurchaseRecordAddress.new(purchase_record_params)
    if @purchase_record_address.valid?
      pay_item
      @purchase_record_address.save
      redirect_to root_path
    else
      gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
      render :index, status: :unprocessable_entity
    end
  end

  private

  def purchase_record_params
    params.require(:purchase_record_address).permit(:post_code, :prefecture_id, :municipality, :street_address, :building_name, :telephone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: purchase_record_params[:token],
      currency: 'jpy'
    )
  end

  def set_items
    @item = Item.find(params[:item_id])
  end
end
