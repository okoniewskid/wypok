require 'will_paginate/array'

class HashtagsController < ApplicationController

  def index
    case
      when params[:sortName]
        case params[:sortName]
          when "asc"
            @hashtags = SimpleHashtag::Hashtag.all.order('name ASC')
            @sn = false;
          when "desc"
            @hashtags = SimpleHashtag::Hashtag.all.order('name DESC')
            @sn = true;
        end
      when params[:sortCount]
        case params[:sortCount]
          when "asc"
            @hashtags = SimpleHashtag::Hashtag.all.group('name').order('COUNT(id) ASC')
            @sc = false;
          when "desc"
            @hashtags = SimpleHashtag::Hashtag.all.group('name').order('COUNT(id) DESC')
            @sc = true;
        end
      else
        @hashtags = SimpleHashtag::Hashtag.all.order('name ASC')
    end
  end

  def show
    @hashtag = SimpleHashtag::Hashtag.find_by_name(params[:hashtag])
    case
      when params[:sortDate]
        case params[:sortDate]
          when "desc"
            @hashtagged = @hashtag.hashtaggables.paginate(page: params[:page], per_page: 10) if @hashtag
            @sd = false;
          when "asc"
            @hashtagged = @hashtag.hashtaggables.reverse.paginate(page: params[:page], per_page: 10) if @hashtag
            @sd = true;
        end
      else
        @hashtagged = @hashtag.hashtaggables.paginate(page: params[:page], per_page: 10) if @hashtag
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

end
