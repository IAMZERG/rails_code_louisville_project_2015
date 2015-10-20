require 'test_helper'

class DecklistsControllerTest < ActionController::TestCase
  setup do
    @decklist = decklists(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:decklists)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create decklist" do
    assert_difference('Decklist.count') do
      post :create, decklist: { description: @decklist.description, name: @decklist.name }
    end

    assert_redirected_to decklist_path(assigns(:decklist))
  end

  test "should show decklist" do
    get :show, id: @decklist
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @decklist
    assert_response :success
  end

  test "should update decklist" do
    patch :update, id: @decklist, decklist: { description: @decklist.description, name: @decklist.name }
    assert_redirected_to decklist_path(assigns(:decklist))
  end

  test "should destroy decklist" do
    assert_difference('Decklist.count', -1) do
      delete :destroy, id: @decklist
    end

    assert_redirected_to decklists_path
  end
end
