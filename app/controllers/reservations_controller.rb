class ReservationsController < ApplicationController

  before_action :set_reservation, only: %i[ show edit update destroy ]

  # GET /reservations or /reservations.json
  def index
    if current_user.is_admin
      puts 'Admin'
      @reservations = Reservation.all
    else
      puts 'Normal User'
      @reservations = current_user.reservations
    end
  end

  # GET /reservations/1 or /reservations/1.json
  def show
  end

  # GET /reservations/new
  def new
    @reservation = current_user.reservations.build
    @reservation.no_of_passengers = 0
    if @flight.nil?
      @flight = Flight.find(params[:flight_id])
      $fl = @flight
      puts 'Found flight oject and id'
      puts @flight.id
    end
    # @reservation = Reservation.new
    # @reservation.flight_id = params[:flight_id]
    # @flight = helpers.get_flight(params[:flight_id])
    # @user = current_user
  end

  # GET /reservations/1/edit
  def edit
    @flight = Flight.find($fl.id)
  end

  # POST /reservations or /reservations.json
  def create
    @reservation = current_user.reservations.build(reservation_params)
    @reservation.flight_id = $fl.id
    @flight = Flight.find($fl.id)
    @reservation.cost = @flight.cost * @reservation.no_of_passengers
    # @reservation.update_attribute(:cost, total_cost)
    # #TODO add if else for false value return from helper method
    respond_to do |format|
      if @reservation.save
        helpers.book_seats(@flight.id,@reservation.no_of_passengers)
        total_cost = @flight.cost * @reservation.no_of_passengers
        @reservation.update_attribute(:cost, total_cost)
        format.html { redirect_to reservation_url(@reservation), notice: "Reservation was successfully created." }
        format.json { render :show, status: :created, location: @reservation }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reservations/1 or /reservations/1.json
  def update

    old_no_of_passengers = @reservation.no_of_passengers
    new_no_of_passengers = params[:reservation][:no_of_passengers].to_i

    if(old_no_of_passengers > new_no_of_passengers)
      helpers.cancel_seats(@reservation.flight_id,old_no_of_passengers-new_no_of_passengers)
      total_cost = Flight.find(@reservation.flight_id).cost * new_no_of_passengers
      @reservation.update_attribute(:cost, total_cost)
    elsif (old_no_of_passengers < new_no_of_passengers)
      helpers.book_seats(@reservation.flight_id,new_no_of_passengers - old_no_of_passengers)
      total_cost = Flight.find(@reservation.flight_id).cost * new_no_of_passengers
      @reservation.update_attribute(:cost, total_cost)
    end

    respond_to do |format|
      if @reservation.update(reservation_params)
        format.html { redirect_to reservation_url(@reservation), notice: "Reservation was successfully updated." }
        format.json { render :show, status: :ok, location: @reservation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reservations/1 or /reservations/1.json
  def destroy
    helpers.cancel_seats(@reservation.flight_id,@reservation.no_of_passengers)
    @reservation.destroy

    respond_to do |format|
      format.html { redirect_to reservations_url, notice: "Reservation was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def reservation_params
      params.require(:reservation).permit(:reservation_id, :no_of_passengers, :ticket_class, :amenities, :no_of_baggage, :cost, :flight_id, :user_id)
    end

end
