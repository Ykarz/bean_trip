require "test_helper"

class StoresControllerTest < ActionDispatch::IntegrationTest
  setup do
    @store = stores(:one)
  end

  test "should get index" do
    get stores_path
    assert_response :success
  end

  test "should get show" do
    get store_path(@store)
    assert_response :success
    assert_select "h1", text: @store.name
  end
end
