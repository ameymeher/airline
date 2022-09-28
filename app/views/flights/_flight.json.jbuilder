json.extract! flight, :id, :name, :flight_id, :class, :manufacturer, :source_city, :destination_city, :capacity, :status, :cost, :created_at, :updated_at
json.url flight_url(flight, format: :json)
