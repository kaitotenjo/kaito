class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
	include SessionsHelper
	
end
class UsersController <  ActionController::Base
end
class MicropostsController < ApplicationController
end
class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def create
    user = User.find(params[:followed_id])
    current_user.follow(user)
    redirect_to user
  end

  def destroy
    user = Relationship.find(params[:id]).followed
    current_user.unfollow(user)
    redirect_to user
  end
end