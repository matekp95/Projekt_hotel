module RoomTypesHelper

  def rooms_for_select
    RoomType.all.collect{|m| m.name}
  end
end
