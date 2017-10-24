require 'test_helper'

class ChefsEditTest < ActionDispatch::IntegrationTest
  def setup
    @chef = Chef.create!(chefname: "beaibca", email: "beaibac@example.com",
                           password: "password", password_confirmation: "password")
  end
  
  test "reject and invalid edit" do
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path(@chef), params: {chef: {chefname: " ", email: "beaibca@gmail.com"} }
    assert_template 'chefs/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
  
  test "accept valid edit" do
    get edit_chef_path(@chef)
    assert_template 'chefs/edit'
    patch chef_path, params: {chef: {chefname: "beaibca", email: "beaibca@gmail.com"} }
    assert_redirected_to @chef
    assert_not flash.empty?
    @chef.reload
    assert_match "beaibca", @chef.chefname
    assert_match "beaibca@gmail.com", @chef.email
  end
end
