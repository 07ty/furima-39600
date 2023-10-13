class ItemsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :destroy, :edit, :update]
  before_action :set_item, only: [:show, :edit, :update, :destroy] 

  def index
    @items = Item.order("created_at DESC")
    @purchase_records = PurchaseRecord.where(item_id: @items.pluck(:id))
  end

  def show
    @purchase_records = PurchaseRecord.where(item_id: @item.id)
  if user_signed_in? && current_user.id != @item.user_id
    redirect_to root_path
  end
end

  def new
    @item = Item.new
  end
    
  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    if current_user == @item.user
      @item.destroy
      redirect_to action: :index
    else
      redirect_to item_path
    end
  end
  

  def edit
    @purchase_records = PurchaseRecord.where(item_id: @item.id)
    if current_user != @item.user || (@purchase_records.present? && @purchase_records.pluck(:item_id).include?(@item.id))
      redirect_to action: :index
    else
      render :edit
    end
  end

  def update
    if @item.update(item_params)
      redirect_to item_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:item).permit(:item, :description, :category_id, :condition_id, :shipping_charge_id, :prefecture_id, :delivery_date_id, :price, :image).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
