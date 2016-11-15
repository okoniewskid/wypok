require 'will_paginate/array'

class HashtagsController < ApplicationController

  def index
    @hashtags = SimpleHashtag::Hashtag.all.sort { |x,y| x.name <=> y.name }
  end

  def show
    @hashtag = SimpleHashtag::Hashtag.find_by_name(params[:hashtag])
    @hashtagged = @hashtag.hashtaggables.paginate(page: params[:page], per_page: 10) if @hashtag
    respond_to do |format|
      format.html
      format.js
    end
  end

end
