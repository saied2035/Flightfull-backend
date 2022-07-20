class Api::V1::ReservationsController < ApplicationController
  def index
    @user = current_user
    if @user.present?
      @reservations = @user.reserved_items.joins(:reservations).select(:id, :name, :flight_number, :image, :price,
                                                                       'reservations.city', 'reservations.date')
      render json: { reservations: @reservations }.to_json
    else
      render json: { Error: 'Devise gem hasn\'t been set up yet.' }
    end
  end

  def create
    user = User.find(params[:user_id])
    item = Item.find(params[:item_id])
    reservation = Reservation.new(city: params[:city], date: Date.parse(params[:date]), user: user, item: item)
    if reservation.save
      render json: { success: "You reserved #{item.name} on #{reservation.date} to #{reservation.city}." }.to_json
    else
      render json: { failure: 'Something went wrong. Please, try again.' }.to_json
    end
  end

  def destroy
    reservation = Reservation.find_by(id: params[:id])
    if reservation
      reservation.destroy
      render json: { success: 'You canceled the reservation successfully.' }.to_json
    else
      render json: { failure: 'Something went wrong. Please, try again.' }.to_json
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:city, :date, :user_id, :item_id)
  end
end
