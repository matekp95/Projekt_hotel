json.extract! room_type, :id, :name, :cost, :max_people, :created_at, :updated_at
json.url room_type_url(room_type, format: :json)
