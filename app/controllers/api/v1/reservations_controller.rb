class Api::V1::ReservationsController < ApplicationController
	def index
		  current_user = User.find_by(id:1) # This is just test because devise gem hasn't been installed yet.
		  @user = current_user 
		  if @user.present?
		  @reservations = @user.reserved_items.joins(:reservations).select(:id,:name,:flight_number,
		  :image,:price, 'reservations.city','reservations.date')
		  render json: {reservations: @reservations}.to_json
	    else
	      render json: {Error: 'Devise gem hasn\'t been set up yet.'}
	    end	
	end	
end
