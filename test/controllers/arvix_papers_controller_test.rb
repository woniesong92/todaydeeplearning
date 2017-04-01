require 'test_helper'

class ArvixPapersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get arvix_papers_index_url
    assert_response :success
  end

  test "should get show" do
    get arvix_papers_show_url
    assert_response :success
  end

end
