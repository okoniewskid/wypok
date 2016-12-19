class UsersController < ApplicationController
    def show
      @user = User.find(params[:id])
      @links = Link.all.where("user_id = "+params[:id])
    end
end
