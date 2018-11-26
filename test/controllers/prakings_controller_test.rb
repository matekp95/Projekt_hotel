require 'test_helper'

class ParkingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @parking = parkings(:one)
  end

  test "should get index" do
    get parkings_url
    assert_response :success
  end

  test "should get new" do
    get new_parking_url
    assert_response :success
  end

  test "should create praking" do
    assert_difference('Praking.count') do
      post parkings_url, params: { praking: { reservation_id: @parking.reservation_id, valid_from: @parking.valid_from, valid_to: @parking.valid_to } }
    end

    assert_redirected_to praking_url(Praking.last)
  end

  test "should show praking" do
    get parking_url(@parking)
    assert_response :success
  end

  test "should get edit" do
    get edit_parking_url(@parking)
    assert_response :success
  end

  test "should update praking" do
    patch parking_url(@parking), params: { praking: { reservation_id: @parking.reservation_id, valid_from: @parking.valid_from, valid_to: @parking.valid_to } }
    assert_redirected_to praking_url(@parking)
  end

  test "should destroy praking" do
    assert_difference('Praking.count', -1) do
      delete parking_url(@parking)
    end

    assert_redirected_to parkings_url
  end
end
