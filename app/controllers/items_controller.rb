class ItemsController < ApplicationController

  before_action :set_item, only: [:show, :edit, :update]
    
    def index
      @items = Item.order("created_at DESC") 
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
    
    private

    def item_params
      params.require(:item).permit(:item_name, :description, :category_id, :condition_id, :shipping_charge_id, :prefecture_id, :delivery_date_id, :price, :image).merge(user_id: current_user.id)
    end
      
    def set_item
      @item = Item.find(params[:id])
    end

    def edit
      unless user_signed_in? && current_user == @item.user
        redirect_to action: :index        
      end
    end

    def update
      if @item.update(item_params)
        redirect_to item_path
      else
        render :edit, status: :unprocessable_entity
      end
    end
  end