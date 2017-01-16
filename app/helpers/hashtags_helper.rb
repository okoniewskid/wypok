module HashtagsHelper
  def linkify_hashtags(hashtaggable_content)
    regex = SimpleHashtag::Hashtag::HASHTAG_REGEX
    hashtagged_content = hashtaggable_content.to_s.gsub(regex) do
      ActionController::Base.helpers.link_to(" "+$&, hashtag_path($2), {class: :hashtag})
    end
    hashtagged_content.html_safe
  end

  def render_hashtaggable(hashtaggable)
    klass        = hashtaggable.class.to_s.underscore
    view_dirname = klass.pluralize
    partial      = klass
    render "#{view_dirname}/#{partial}", {klass.to_sym => hashtaggable}
  end
  
  def destroy_hashtaggables(ids, type)
      @dl = ids.length - 1
      @st = ''
      for i in 0..@dl
        if @dl != i
          @st += 'hashtaggable_id = ' + ids[i].to_s + ' OR '
        else
          @st += 'hashtaggable_id = ' + ids[i].to_s
        end
      end
      if @st != ''
        SimpleHashtag::Hashtagging.delete_all "hashtaggable_type = '"+type+"' AND ("+@st+")"
      end
  end
end
