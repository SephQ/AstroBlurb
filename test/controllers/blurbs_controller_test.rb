require "test_helper"

class BlurbsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @blurb = blurbs(:one)
  end

  test "should get index" do
    get blurbs_url
    assert_response :success
  end

  test "should get new" do
    get new_blurb_url
    assert_response :success
  end

  test "should create blurb" do
    assert_difference("Blurb.count") do
      post blurbs_url, params: { blurb: { planet_replacements: @blurb.planet_replacements, text: @blurb.text, title: @blurb.title } }
    end

    assert_redirected_to blurb_url(Blurb.last)
  end

  test "should show blurb" do
    get blurb_url(@blurb)
    assert_response :success
  end

  test "should get edit" do
    get edit_blurb_url(@blurb)
    assert_response :success
  end

  test "should update blurb" do
    patch blurb_url(@blurb), params: { blurb: { planet_replacements: @blurb.planet_replacements, text: @blurb.text, title: @blurb.title } }
    assert_redirected_to blurb_url(@blurb)
  end

  test "should destroy blurb" do
    assert_difference("Blurb.count", -1) do
      delete blurb_url(@blurb)
    end

    assert_redirected_to blurbs_url
  end
end
