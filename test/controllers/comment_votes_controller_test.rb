require "test_helper"

class CommentVotesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get comment_votes_create_url
    assert_response :success
  end

  test "should get update" do
    get comment_votes_update_url
    assert_response :success
  end
end
