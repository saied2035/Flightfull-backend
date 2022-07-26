class Api::V1::ReservationsController < ApplicationController
  def index
    @user = current_user
    if @user.present?
      @reservations = @user.reserved_items.joins(:reservations)
        .select('reservations.id', :name, :flight_number, :image, :price,
                'reservations.city', 'reservations.date').distinct
      render json: { reservations: @reservations }.to_json
    else
      render json: { Error: 'User isn\'t exist' }
    end
  end

  def create
    user = User.find_by(id: params[:user_id])
    item = Item.find_by(id: params[:item_id])
    reservation = Reservation.new(city: params[:city], date: Date.parse(params[:date].to_s), user: user, item: item)
    if reservation.save
      render json: { success: "You reserved #{item.name} on #{reservation.date} to #{reservation.city}." }.to_json
    else
      render json: { failure: 'Something went wrong. Please, try again.' }.to_json
    end
  end

  def destroy
    user = current_user
    @reservations = user.reserved_items.joins(:reservations)
      .select('reservations.id', :name, :flight_number, :image, :price,
              'reservations.city', 'reservations.date').distinct
    reservation = Reservation.find_by(id: params[:id])
    if reservation
      reservation.destroy
      render json: { reservations: @reservations, success: 'You canceled the reservation successfully.' }.to_json
    else
      render json: { failure: 'Something went wrong. Please, try again.' }.to_json
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:city, :date, :user_id, :item_id)
  end
end
