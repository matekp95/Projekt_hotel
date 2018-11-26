json.extract! reservation, :id, :valid_from, :valid_to, :token, :user_id, :room_type, :created_at, :updated_at
json.url reservation_url(reservation, format: :json)
