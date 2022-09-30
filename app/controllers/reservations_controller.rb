class ReservationsController < ApplicationController

  before_action :set_reservation, only: %i[ show edit update destroy ]

  # GET /reservations or /reservations.json
  def index
    @reservations = Reservation.all
  end

  # GET /reservations/1 or /reservations/1.json
  def show
  end

  # GET /reservations/new
  def new
    @reservation = Reservation.new
    @reservation.flight_id = params[:flight_id]
    @flight = helpers.get_flight(params[:flight_id])
    @user = current_user
  end

  # GET /reservations/1/edit
  def edit
  end

  # POST /reservations or /reservations.json
  def create
    @flight = helpers.get_flight(params[:reservation][:flight_id])
    @reservation = Reservation.new(reservation_params)
    set_unique_reservation_id
    @reservation.user_id = current_user.id
    @reservation.flight_id = @flight.id

    #TODO add if else for false value return from helper method
    helpers.book_seats(@flight.id,@reservation.no_of_passengers)

    respond_to do |format|
      if @reservation.save!
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

    if(old_no_of_passengers > :no_of_passengers)
      helpers.cancel_seats(@reservation.flight_id,old_no_of_passengers-:no_of_passengers)
    elsif (old_no_of_passengers < :no_of_passengers)
      helpers.book_seats(@reservation.flight_id,:no_of_passengers - old_no_of_passengers)
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
    helpers.cancel_seats(@flight.id,@reservation.no_of_passengers)
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
      params.require(:reservation).permit(:reservation_id, :no_of_passengers, :ticket_class, :amenities, :no_of_baggage, :cost, :flight_id)
    end

    def set_unique_reservation_id
      number = 0
      loop do
        number = SecureRandom.random_number(10000000000)
        break number unless User.where(user_id:number).exists?
      end
      @reservation.reservation_id = number
    end
end
