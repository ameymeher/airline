require "application_system_test_case"

class BaggagesTest < ApplicationSystemTestCase
  setup do
    @baggage = baggages(:one)
  end

  test "visiting the index" do
    visit baggages_url
    assert_selector "h1", text: "Baggages"
  end

  test "should create baggage" do
    visit baggages_url
    click_on "New baggage"

    fill_in "Baggage", with: @baggage.baggage_id
    fill_in "Cost", with: @baggage.cost
    fill_in "Weight", with: @baggage.weight
    click_on "Create Baggage"

    assert_text "Baggage was successfully created"
    click_on "Back"
  end

  test "should update Baggage" do
    visit baggage_url(@baggage)
    click_on "Edit this baggage", match: :first

    fill_in "Baggage", with: @baggage.baggage_id
    fill_in "Cost", with: @baggage.cost
    fill_in "Weight", with: @baggage.weight
    click_on "Update Baggage"

    assert_text "Baggage was successfully updated"
    click_on "Back"
  end

  test "should destroy Baggage" do
    visit baggage_url(@baggage)
    click_on "Destroy this baggage", match: :first

    assert_text "Baggage was successfully destroyed"
  end
end
