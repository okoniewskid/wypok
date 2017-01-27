class UsersController < ApplicationController
include HashtagsHelper

    def index
      @users = User.paginate(:page => params[:page], :per_page => 30)
      case
        when params[:view] 
          case params[:view] 
            when "admin"
              pm = Role.find_by name: 'admin'
              if pm != nil
                @va = true
                @users = @users.joins('LEFT JOIN users_roles ON
                      users_roles.user_id = users.id')
                      .where('users_roles.role_id = '+ pm.id.to_s)
              else
                @va = false
              end
            else
              @va = false;
          end
      end
      case 
        when params[:search]
          @users = @users.search(params[:search])
          case
            when params[:sortName]
              case params[:sortName]
                when "asc"
                  @users= @users.order('name ASC')
                  @sn = false;
                when "desc"
                  @users = @users.order('name DESC')
                  @sn = true
              end
            else
            @users = @users.all.order('name ASC')
          end
        else
          @users = @users.all.order('name ASC')
      end
      if current_user
        if User.find(current_user.id).has_role? :admin
          @iAdminRole = true;
        else
          @iAdminRole = false;
        end
      else
        @iAdminRole = false;
      end
    end
    
    def show
      @user = User.find(params[:id])
      if @user.has_role? :admin
        @adminRole = true
      else
        @adminRole = false
      end
      if @user.has_role? :email
        @emailRole = true
      else
        @emailRole = false
      end
      if current_user
        if User.find(current_user.id).has_role? :admin
          @iAdminRole = true;
        else
          @iAdminRole = false;
        end
        if(@user.id === current_user.id)
          iIsThisUser = true
        else
          iIsThisUser = false
        end
      else
        @iAdminRole = false;
        iIsThisUser = false;
      end
      if @emailRole || @iAdminRole || iIsThisUser
        @viewEmail = true
      else
        @viewEmail = false
      end
      @links = Link.all.where("user_id = "+params[:id]).paginate(:page => params[:page], :per_page => 10)
      case 
        when params[:search]
          @links = @links.search(params[:search])
          case
            when params[:sortDate]
              case params[:sortDate]
                when "asc"
                  @links= @links.all.order('created_at ASC')
                  @sd = true;
                  @sn = false;
                  @sv = false;
                when "desc"
                  @links= @links.all.order('created_at DESC')
                  @sd = false;
              end
            when params[:sortName]
              case params[:sortName]
                when "asc"
                  @links= @links.order('title ASC')
                  @sn = true;
                  @sd = false;
                  @sv = false;
                when "desc"
                  @links= @links.order('title DESC')
                  @sn = false;
              end
            when params[:sortVote]
              case params[:sortVote]
                when "desc"
                  @links= @links.order('((cached_votes_up + 1.9208) / '+
                  '(cached_votes_up + cached_votes_down) - 1.96 * '+
                  '((cached_votes_up * cached_votes_down) / '+
                  '(cached_votes_up + cached_votes_down) + 0.9604) / '+
                  '(cached_votes_up + cached_votes_down)) / '+
                  '(1 + 3.8416 / (cached_votes_up + cached_votes_down))  DESC')
                  @sv = true;
                  @sd = false;
                  @sn = false;
                when "asc"
                  @links= @links.order('((cached_votes_up + 1.9208) / '+
                  '(cached_votes_up + cached_votes_down) - 1.96 * '+
                  '((cached_votes_up * cached_votes_down) / '+
                  '(cached_votes_up + cached_votes_down) + 0.9604) / '+
                  '(cached_votes_up + cached_votes_down)) / '+
                  '(1 + 3.8416 / (cached_votes_up + cached_votes_down))  ASC')
                  @sv = false;
              end
            else
              @links= @links.all.order('created_at DESC')
          end
      else
        @links= @links.all.order('created_at DESC')
      end
      respond_to do |format|
          format.html
          format.js
      end
    end
    
    def edit
      @user = User.find(params[:id])
      if @user.has_role? :admin
        @adminRole = true
      else
        @adminRole = false
      end
      if @user.has_role? :block
        @blockRole = true
      else
        @blockRole = false
      end
      if @user.has_role? :email
        @emailRole = true
      else
        @emailRole = false
      end
      if current_user
        u = User.find(current_user.id)
        if u.has_role? :admin
          @allow = true
        else
          @allow = false
          flash[:notice] = "Brak uprawnień!"
        end
      else
        @allow = false
        flash[:notice] = "Brak uprawnień!"
      end
    end
    
    def update
      @user = User.find(params[:id])
      if @user.has_role? :admin
        @adminRole = true
      else
        @adminRole = false
      end
      if @user.has_role? :block
        @blockRole = true
      else
        @blockRole = false
      end
      if @user.has_role? :email
        @emailRole = true
      else
        @emailRole = false
      end
      if current_user
        u = User.find(current_user.id)
        if u.has_role? :admin
          @allow = true
        else
          @allow = false
          flash[:notice] = "Brak uprawnień!"
        end
      else
        @allow = false
        flash[:notice] = "Brak uprawnień!"
      end
      if @user.update_attributes(params.require(:user).permit(:name, :email, :avatar, :password, :password_confirmation))
        if params[:admin]
          if !(@user.has_role? :admin)
            @user.add_role(:admin)
          end
    	  else
          if @user.has_role? :admin
            @user.remove_role(:admin)
          end
        end
        if params[:block]
          if !(@user.has_role? :block)
            @user.add_role(:block)
          end
    	  else
          if @user.has_role? :block
            @user.remove_role(:block)
          end
        end
        if params[:hiddenEmail]
          if @user.has_role? :email
            @user.remove_role(:email)
          end
        else
          if !(@user.has_role? :email)
            @user.add_role(:email)
          end
        end
        redirect_to edit_user_path(@user), :notice => "Dane zostały zmienione."
      else
			  case @user.errors.count
			    when 1
			      @jakiBlad = "błędu"
			    else
			      @jakiBlad = "błędów"
			  end
			  render "edit"
      end
    end
    
    def destroy
      @user = User.find(params[:id])
      @links = @user.links
      @dl = @links.length - 1
      for i in 0..@dl
        destroy_hashtaggables(@links[i].comments.pluck('id'), 'Comment')
      end
      destroy_hashtaggables(@links.pluck('id'), 'Link')
      @user.destroy
      redirect_to users_path, :notice => "Konto zostało usunięte."
    end
end
