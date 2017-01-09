class UsersController < ApplicationController
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
end
