require 'test_helper'

class RakumachisControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get rakumachis_index_url
    assert_response :success
  end

end
