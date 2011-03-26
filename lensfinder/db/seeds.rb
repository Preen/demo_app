# encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

user = User.create  :email => 'nalle@mia.com',
                    :password => 'guessit',
                    :password_confirmation => 'guessit'

retailer = Retailer.create [{:title => 'Lensia'}]


Category.create [ {:name => '2-veckorlinser'},
                  {:name => 'Dygnet-runt-linser'},
                  {:name => 'Endagslinser'},
                  {:name => 'Färgade linser'},
                  {:name => 'Månadslinser'} ]

Product.create  [ {:title => 'One Day Acuvue'},
                  {:title => 'Focus Dailies'},
                  {:title => 'Proclear'},
                  {:title => 'Biomedics 55'} ]

Size.create [{:size => '3'},{:size => '6'},{:size => '30'},{:size => '60'},{:size => '90'}]

Price.create [{:price => '205', :retailer_id => 1, :size_id => 1, :product_id => 1},
              {:price => '305', :retailer_id => 1, :size_id => 2, :product_id => 1},
              {:price => '405', :retailer_id => 1, :size_id => 3, :product_id => 1}]

retailer2 = Retailer.first

retailer2.create_profile :shippingCost => '305'

user.retailers.create :title => 'Färgadelinser'

user.products.create :title => 'Freshlook Colorblends'

user.prices.create [{:price => '505', :retailer_id => 2, :size_id => 1, :product_id => 5, :user_id => 1},
                   {:price => '605', :retailer_id => 2, :size_id => 2, :product_id => 5, :user_id => 1}]
