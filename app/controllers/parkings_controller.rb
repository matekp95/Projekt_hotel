class ParkingsController < ApplicationController
  before_action :set_praking, only: [:show, :edit, :update, :destroy]

  # GET /prakings
  # GET /prakings.json
  def index
    @parkings = Parking.all
  end

  # GET /prakings/1
  # GET /prakings/1.json
  def show
  end

  # GET /prakings/new
  def new
    @parking = Parking.new
  end

  # GET /prakings/1/edit
  def edit
  end

  # POST /prakings
  # POST /prakings.json
  def create
    @parking = Parking.new(parking_params)
    @parking.reservation = Reservation.where(id: params[:parking][:reservation_id]).first

    respond_to do |format|
      if @parking.save
        @parking.reservation.has_parking = true
        @parking.reservation.save(validate: false)

        format.html { redirect_to @parking, notice: 'Parking was successfully created.' }
        format.json { render :show, status: :created, location: @parking }
      else
        format.html { render :new }
        format.json { render json: @parking.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /prakings/1
  # PATCH/PUT /prakings/1.json
  def update
    respond_to do |format|
      if @parking.update(parking_params)
        format.html { redirect_to @parking, notice: 'Parking was successfully updated.' }
        format.json { render :show, status: :ok, location: @parking }
      else
        format.html { render :edit }
        format.json { render json: @parking.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /prakings/1
  # DELETE /prakings/1.json
  def destroy
    @parking.reservation.has_parking = false
    @parking.reservation.save(validate: false)
    @parking.destroy
    respond_to do |format|
      format.html { redirect_to parkings_url, notice: 'Parking was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_praking
      @parking = Parking.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def parking_params
      params.require(:parking).permit(:valid_from, :valid_to, :reservation_id)
    end
end
