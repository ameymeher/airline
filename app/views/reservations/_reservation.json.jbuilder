json.extract! reservation, :id, :reservation_id, :no_of_passengers, :ticket_class, :amenitites, :no_of_baggage, :cost, :created_at, :updated_at
json.url reservation_url(reservation, format: :json)
