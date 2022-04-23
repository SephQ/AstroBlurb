require "application_system_test_case"

class BlurbsTest < ApplicationSystemTestCase
  setup do
    @blurb = blurbs(:one)
  end

  test "visiting the index" do
    visit blurbs_url
    assert_selector "h1", text: "Blurbs"
  end

  test "should create blurb" do
    visit blurbs_url
    click_on "New blurb"

    fill_in "Planet replacements", with: @blurb.planet_replacements
    fill_in "Text", with: @blurb.text
    fill_in "Title", with: @blurb.title
    click_on "Create Blurb"

    assert_text "Blurb was successfully created"
    click_on "Back"
  end

  test "should update Blurb" do
    visit blurb_url(@blurb)
    click_on "Edit this blurb", match: :first

    fill_in "Planet replacements", with: @blurb.planet_replacements
    fill_in "Text", with: @blurb.text
    fill_in "Title", with: @blurb.title
    click_on "Update Blurb"

    assert_text "Blurb was successfully updated"
    click_on "Back"
  end

  test "should destroy Blurb" do
    visit blurb_url(@blurb)
    click_on "Destroy this blurb", match: :first

    assert_text "Blurb was successfully destroyed"
  end
end
