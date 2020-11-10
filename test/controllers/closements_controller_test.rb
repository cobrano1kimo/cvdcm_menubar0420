require 'test_helper'

class ClosementsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @closement = closements(:one)
  end

  test "should get index" do
    get closements_url
    assert_response :success
  end

  test "should get new" do
    get new_closement_url
    assert_response :success
  end

  test "should create closement" do
    assert_difference('Closement.count') do
      post closements_url, params: { closement: { close_day: @closement.close_day } }
    end

    assert_redirected_to closement_url(Closement.last)
  end

  test "should show closement" do
    get closement_url(@closement)
    assert_response :success
  end

  test "should get edit" do
    get edit_closement_url(@closement)
    assert_response :success
  end

  test "should update closement" do
    patch closement_url(@closement), params: { closement: { close_day: @closement.close_day } }
    assert_redirected_to closement_url(@closement)
  end

  test "should destroy closement" do
    assert_difference('Closement.count', -1) do
      delete closement_url(@closement)
    end

    assert_redirected_to closements_url
  end
end
