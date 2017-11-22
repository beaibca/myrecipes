require 'test_helper'

class ChefsListingTest < ActionDispatch::IntegrationTest
  def setup
    @chef = Chef.create!(chefname: "beaibca", email: "beaibac@example.com",
                         password: "password", password_confirmation: "password")
    @admin_user = Chef.create!(chefname: "beaibca1", email: "beaibac1@example.com",
                         password: "password", password_confirmation: "password", admin: true)
  end
 
  test "should get recipes index" do
    get chefs_path
    assert_response :success
  end
 
  test "should get recipes listing" do
    get chefs_path
    assert_template 'chefs/index'
    assert_select "a[href=?]", chef_path(@chef), text: @chef.chefname.capitalize
  end
  
  test "should delete chef" do
    sign_in_as(@admin_user, "password")
    get chefs_path
    assert_template 'chefs/index'
    assert_difference 'Chef.count', -1 do
      delete chef_path(@chef)
    end
    assert_redirected_to chefs_path
    assert_not flash.empty?
  end
end
