class Api::V1::ItemsController < ApplicationController
    def index
      @items = Item.all
      render json: @items, status: :ok
    end
  
    def create
      @item = Item.new(item_params)
      @payload = {
        error: 'An error occurred while creating the item',
        status: 400
      }
  
      if @item.save
        render json: @item, status: :created
      else
        render json: @payload, status: :bad_request
      end
    end
  
    def update
      @item = Item.find(params[:id])
      @payload = {
        error: 'An error occurred while updating the item',
        status: 400
      }
  
      if @item.update(item_params)
        render json: @item, status: :ok
      else
        render json: @payload, status: :bad_request
      end
    end
  
    def destroy
      @item = Item.find(params[:id])
      @payload = {
        error: 'An error occurred while deleting the item',
        status: 400
      }
  
      if @item.destroy
        render json: @item, status: :ok
      else
        render json: @payload, status: :bad_request
      end
    end
  
    private
  
    def item_params
      params.require(:item).permit(:name, :flight_number, :image, :price, :user_id)
    end
  end
  