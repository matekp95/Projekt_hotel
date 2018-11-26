class StatisticsController < ApplicationController
  before_action :check_access
  before_action :authenticate_user!

  def new
    puts params
    @statistics = Statistic.new(get_params)
  end

  def perform
    puts get_params
    @statistics = Statistic.new(get_params)
    if @statistics.valid?
      @reservations_taken = @statistics.reservations_taken
      @people_visited_hotel = @statistics.people_visited_hotel
      @reservations_left = (RoomType.count * RoomType::MAX_EACH_ROOM_COUNT) - @reservations_taken
      @parkings_taken = @statistics.parkings_taken
      @room_types = RoomType.all
    else
      render :new
    end
  end

  private

  def check_access
    if current_user.present?
      unless current_user.user_role == 'admin'
        head(403)
      end
    else
      redirect_to new_user_session_path
    end
  end

  def get_params
    if params[:statistic].blank?
      {valid_from: Time.zone.now, valid_to: Time.zone.now.tomorrow}
    else
      params.require(:statistic).permit(:valid_from, :valid_to)
    end
  end
end
