module CommentsHelper
    
    def bius(content)
        content.to_str.gsub(/(\[\/?(b|i|u|s)\])/) do |match|
            case match
                when "[b]"
                    "<b>"
                when "[i]"
                    "<i>"
                when "[u]"
                    "<span class='underline'>"
                when "[s]"
                    "<span class='strike'>"
                when "[/b]"
                    "</b>"
                when "[/i]"
                    "</i>"
                else
                    "</span>"
            end
        end
    end
    
    def enter(content)
        content.to_str.gsub(/\n/) do |match|
            %(<br>)
        end.html_safe if content.present?
    end
end
