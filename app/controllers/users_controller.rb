class UsersController < ApplicationController
  skip_before_filter :save_uri
end