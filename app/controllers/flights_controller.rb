class FlightsController < ApplicationController
  before_action :set_flight, only: %i[ show edit update destroy ]
  before_action :adminAuthorized, only: %i[ new edit create update destroy ]

  # GET /flights or /flights.json
  def index
    @flights = Flight.all
  end

  # GET /flights/1 or /flights/1.json
  def show
  end

  # GET /flights/new
  def new
    @flight = Flight.new
  end

  # GET /flights/1/edit
  def edit
  end

  # POST /flights or /flights.json
  def create
    @flight = Flight.new(flight_params)
    generate_unique_confirmation_no
    set_status

    respond_to do |format|
      if @flight.save
        format.html { redirect_to flight_url(@flight), notice: "Flight was successfully created." }
        format.json { render :show, status: :created, location: @flight }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @flight.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /flights/1 or /flights/1.json
  def update
    set_status

    respond_to do |format|
      if @flight.update(flight_params)
        format.html { redirect_to flight_url(@flight), notice: "Flight was successfully updated." }
        format.json { render :show, status: :ok, location: @flight }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @flight.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /flights/1 or /flights/1.json
  def destroy
    @flight.destroy

    respond_to do |format|
      format.html { redirect_to flights_url, notice: "Flight was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_flight
      @flight = Flight.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def flight_params
      params.require(:flight).permit(:name, :ticket_class, :manufacturer, :source_city, :destination_city, :capacity, :cost)
    end

    def generate_unique_confirmation_no
      number = 0
      loop do
        number = SecureRandom.random_number(10000000000)
        break number unless User.where(user_id:number).exists?
      end
      @flight.confirmation_no = number
    end

    def set_status
      if @flight.capacity > 0
        @flight.status = "Available"
      elsif
        @flight.status = "Booked"
      end
    end
end
