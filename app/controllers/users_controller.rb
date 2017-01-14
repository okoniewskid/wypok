class UsersController < ApplicationController
    def index
      @users = User.paginate(:page => params[:page], :per_page => 20)
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
    end
    
    def show
      @user = User.find(params[:id])
      if @user.has_role? :admin
        @adminRole = true
      else
        @adminRole = false
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
        @block.Role = false
      end
    end
    
    def update
      @user = User.find(params[:id])
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
        redirect_to users_path, :notice => "Dane zostały zmienione"
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
      @user.destroy
      redirect_to users_path, :notice => "Konto zostało usunięte"
    end
end
