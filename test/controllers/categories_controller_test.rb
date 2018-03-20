require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest

  before_action :require_admin, except:[:index, :show]

  def setup
    @category= Category.create(name: "sports")
    @user= User.create(name: "john", email:"john@example.com", password: "password", admin: true)
  end

  test "should get categories index" do
    get categories_path
    assert_response :success
  end

  test "should get new" do
    sign_in_as(@user,"password")
    get new_category_path
    assert_response :success
  end

  test "should get show" do
    get category_path(@category)
    assert_response :success
  end

  test "should redirect create when admin not logged in" do
    assert_no_difference 'Category.count' do
      post categories_path, params: {category: {name: "sports"}}
    end
    assert_redirected_to categories_path
  end

  private

  def require_admin
    if !logged_in? || (logged_in? and !current_user.admin?)
      flash[:danger]= "Only Admins can perform that action"
      redirect_to categories_path
    end
  end
end
