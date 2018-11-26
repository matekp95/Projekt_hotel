class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:create, :update, :destroy, :index, :show]

  # GET /reservations
  # GET /reservations.json
  def index
    @reservations = current_user.reservations
  end

  def index_admin
    @reservations = Reservation.all
  end

  # GET /reservations/1
  # GET /reservations/1.json
  def show
  end

  def home
    @reservation = Reservation.new
    @max_users = RoomType.all.pluck(:max_people).max
    @number_of_users = generate_hash
    @reservations = Reservation.all
  end

  # GET /reservations/new
  def new
    @reservation = Reservation.new
    @max_users = RoomType.all.pluck(:max_people).max
    @number_of_users = generate_hash
  end

  # GET /reservations/1/edit
  def edit
  end

  # POST /reservations
  # POST /reservations.json
  def create
    @reservation = current_user.reservations.build(reservation_params)
    @max_users = RoomType.all.pluck(:max_people).max
    @number_of_users = generate_hash
    if params[:check] == 'room_availability'

      if @reservation.valid?
        redirect_to root_path, notice: 'Room is available.'
      else
        redirect_to root_path, notice: 'Room is not available.'
      end
    else
      respond_to do |format|
        if @reservation.save
          if params['reservation']['has_parking'].to_i == 1
            parking = Parking.new(parking_params)
            parking.reservation_id = @reservation.id
            parking.save
          end
          ConfirmationMailer.with(reservation: @reservation).confirmation_email.deliver
          Delayed::Job.enqueue(MailerJob.new({reservation: @reservation}), run_at: @reservation.valid_from - 6.days )
          format.html {redirect_to @reservation, notice: 'Reservation was successfully created. Confirmation was send to your email'}
          format.json {render :show, status: :created, location: @reservation}
        else
          format.html {render :new}
          format.json {render json: @reservation.errors, status: :unprocessable_entity}
        end
      end
    end
  end

  # PATCH/PUT /reservations/1
  # PATCH/PUT /reservations/1.json
  def update
    respond_to do |format|
      if @reservation.update(reservation_params)
        format.html {redirect_to @reservation, notice: 'Reservation was successfully updated.'}
        format.json {render :show, status: :ok, location: @reservation}
      else
        format.html {render :edit}
        format.json {render json: @reservation.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /reservations/1
  # DELETE /reservations/1.json
  def destroy
    @reservation.destroy
    respond_to do |format|
      ConfirmationMailer.with(reservation: @reservation).delete_confirmation_email.deliver
      format.html {redirect_to reservations_url, notice: 'Reservation was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  def check_room_avability
    @ey = true
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_reservation
    puts params
    @reservation = Reservation.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def reservation_params
    params['reservation']['token'] = SecureRandom.uuid
    params.require(:reservation).permit(:valid_from, :valid_to, :num_of_user, :has_parking, :room_type, :token)
  end

  def parking_params
    params.require(:reservation).permit(:valid_from, :valid_to)
  end

  def generate_hash
    number_hash = {}
    @max_users.times do |n|
      number_hash[n + 1] = n + 1
    end
    number_hash
  end
end
