require 'test_helper'

class ChefsTest < ActionDispatch::IntegrationTest
 def setup
  @chef = Chef.create!(chefname: "beaibca", email: "beaibac@example.com",
                         password: "password", password_confirmation: "password")
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
end
