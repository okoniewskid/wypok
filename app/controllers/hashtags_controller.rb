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
            @hashtags = SimpleHashtag::Hashtag.all
            .joins('LEFT JOIN simple_hashtag_hashtaggings ON
            simple_hashtag_hashtaggings.hashtag_id = simple_hashtag_hashtags.id')
            .group('simple_hashtag_hashtaggings.hashtag_id').
            order('COUNT(simple_hashtag_hashtags.id) ASC')
            @sc = false;
          when "desc"
            @hashtags = SimpleHashtag::Hashtag.all
            .joins('LEFT JOIN simple_hashtag_hashtaggings ON
            simple_hashtag_hashtaggings.hashtag_id = simple_hashtag_hashtags.id')
            .group('simple_hashtag_hashtaggings.hashtag_id').
            order('COUNT(simple_hashtag_hashtags.id) DESC')
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
          when "asc"
            @hashtagged = @hashtag.hashtaggables.paginate(page: params[:page], per_page: 10) if @hashtag
            @sd = true
          when "desc"
            @hashtagged = @hashtag.hashtaggables.reverse.paginate(page: params[:page], per_page: 10) if @hashtag
            @sd = false
        end
      else
        @hashtagged = @hashtag.hashtaggables.reverse.paginate(page: params[:page], per_page: 10) if @hashtag
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

end
