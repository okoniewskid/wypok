module CommentsHelper
    def bold(content)
        content.to_str.gsub(/\[b\](.)+\[\/b\]/) do |match|
            match = "<b>"+match.from(3).to(-5)+"</b>"
        end.html_safe if content.present?
    end
  
    def italic(content)
        content.to_str.gsub(/\[i\](.)+\[\/i\]/) do |match|
            match = "<i>"+match.from(3).to(-5)+"</i>"
        end.html_safe if content.present?
    end

    def underline(content)
        content.to_str.gsub(/\[u\](.)+\[\/u\]/) do |match|
            match = "<span class='underline'>"+match.from(3).to(-5)+"</span>"
        end.html_safe if content.present?
    end

    def strikethrough(content)
        content.to_str.gsub(/\[s\](.)+\[\/s\]/) do |match|
            match = "<span class='strike'>"+match.from(3).to(-5)+"</span>"
        end.html_safe if content.present?
    end
end
