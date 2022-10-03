class BaggagesController < ApplicationController
  before_action :set_baggage, only: %i[ show edit update destroy ]

  # GET /baggages or /baggages.json
  def index
      @baggages = Baggage.where(reservation_id: params[:reservation_id])
      $reservation_id = params[:reservation_id]
  end

  # GET /baggages/1 or /baggages/1.json
  def show
  end

  # GET /baggages/new
  def new
    @baggage = Baggage.new
    @reservation = Reservation.find_by(id: $reservation_id)
  end

  # GET /baggages/1/edit
  def edit
    @reservation = Reservation.find_by(id: $reservation_id)
  end

  # POST /baggages or /baggages.json
  def create
    @reservation = Reservation.find_by(id: $reservation_id)
    @baggage = Baggage.new(baggage_params)
    @baggage.reservation = @reservation
    @baggage.user = @current_user
    respond_to do |format|
      if @baggage.save
        @reservation.cost = @reservation.cost + @baggage.cost
        @reservation.save
        format.html { redirect_to baggage_url(@baggage), notice: "Baggage was successfully created." }
        format.json { render :show, status: :created, location: @baggage }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @baggage.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /baggages/1 or /baggages/1.json
  def update
    old_baggage_cost = @baggage.cost
    @reservation = Reservation.find_by(id: $reservation_id)
    respond_to do |format|
      if @baggage.update(baggage_params)
        @reservation.cost = @reservation.cost - old_baggage_cost + @baggage.cost
        @reservation.save
        format.html { redirect_to baggage_url(@baggage), notice: "Baggage was successfully updated." }
        format.json { render :show, status: :ok, location: @baggage }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @baggage.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /baggages/1 or /baggages/1.json
  def destroy
    @reservation = Reservation.find_by(id: $reservation_id)
    @reservation.cost = @reservation.cost - @baggage.cost
    @reservation.save
    @baggage.destroy

    respond_to do |format|
      format.html { redirect_to baggages_path(:reservation_id => @baggage.reservation_id), notice: "Baggage was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_baggage
      @baggage = Baggage.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def baggage_params
      params.require(:baggage).permit(:id, :weight, :cost, :reservation_id)
    end
end
