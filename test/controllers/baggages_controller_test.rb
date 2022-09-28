require "test_helper"

class BaggagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @baggage = baggages(:one)
  end

  test "should get index" do
    get baggages_url
    assert_response :success
  end

  test "should get new" do
    get new_baggage_url
    assert_response :success
  end

  test "should create baggage" do
    assert_difference("Baggage.count") do
      post baggages_url, params: { baggage: { baggage_id: @baggage.baggage_id, cost: @baggage.cost, weight: @baggage.weight } }
    end

    assert_redirected_to baggage_url(Baggage.last)
  end

  test "should show baggage" do
    get baggage_url(@baggage)
    assert_response :success
  end

  test "should get edit" do
    get edit_baggage_url(@baggage)
    assert_response :success
  end

  test "should update baggage" do
    patch baggage_url(@baggage), params: { baggage: { baggage_id: @baggage.baggage_id, cost: @baggage.cost, weight: @baggage.weight } }
    assert_redirected_to baggage_url(@baggage)
  end

  test "should destroy baggage" do
    assert_difference("Baggage.count", -1) do
      delete baggage_url(@baggage)
    end

    assert_redirected_to baggages_url
  end
end
