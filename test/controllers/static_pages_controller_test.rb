require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
  end

  test "should get welcome" do
    get :welcome
    assert_response :success
  end

  test "should get not_in_the_list" do
    get :not_in_the_list
    assert_response :success
  end

end
