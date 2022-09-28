require "application_system_test_case"

class FlightsTest < ApplicationSystemTestCase
  setup do
    @flight = flights(:one)
  end

  test "visiting the index" do
    visit flights_url
    assert_selector "h1", text: "Flights"
  end

  test "should create flight" do
    visit flights_url
    click_on "New flight"

    fill_in "Capacity", with: @flight.capacity
    fill_in "Class", with: @flight.class
    fill_in "Cost", with: @flight.cost
    fill_in "Destination city", with: @flight.destination_city
    fill_in "Flight", with: @flight.flight_id
    fill_in "Manufacturer", with: @flight.manufacturer
    fill_in "Name", with: @flight.name
    fill_in "Source city", with: @flight.source_city
    fill_in "Status", with: @flight.status
    click_on "Create Flight"

    assert_text "Flight was successfully created"
    click_on "Back"
  end

  test "should update Flight" do
    visit flight_url(@flight)
    click_on "Edit this flight", match: :first

    fill_in "Capacity", with: @flight.capacity
    fill_in "Class", with: @flight.class
    fill_in "Cost", with: @flight.cost
    fill_in "Destination city", with: @flight.destination_city
    fill_in "Flight", with: @flight.flight_id
    fill_in "Manufacturer", with: @flight.manufacturer
    fill_in "Name", with: @flight.name
    fill_in "Source city", with: @flight.source_city
    fill_in "Status", with: @flight.status
    click_on "Update Flight"

    assert_text "Flight was successfully updated"
    click_on "Back"
  end

  test "should destroy Flight" do
    visit flight_url(@flight)
    click_on "Destroy this flight", match: :first

    assert_text "Flight was successfully destroyed"
  end
end
