module FlightsHelper

  def get_flight(flight_id)
    return Flight.find_by_flight_id(flight_id)
  end
  def book_seats(flight_id,seats)
    flight = get_flight(flight_id)
    if(seats <= flight.capacity)
      flight.capacity -= seats
      if flight.capacity == 0
        flight.status = "Full"
      end
      flight.save
      return true
    end
    return false
  end

  def cancel_seats(flight_id,seats)
    flight = get_flight(flight_id)
    flight.capacity += seats
    flight.status = "Available"
    flight.save
  end

end
