class HashtagsController < ApplicationController

  def index
    @hashtags = SimpleHashtag::Hashtag.all.sort { |x,y| x.name <=> y.name }
  end

  def show
    @hashtag = SimpleHashtag::Hashtag.find_by_name(params[:hashtag])
    @hashtagged = @hashtag.hashtaggables if @hashtag
  end

end
