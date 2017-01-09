class UsersController < ApplicationController
    def show
      @user = User.find(params[:id])
      if @user.has_role? :admin
        @adminRole = true
      else
        @adminRole = false
      end
      @links = Link.all.where("user_id = "+params[:id])
    end
end
