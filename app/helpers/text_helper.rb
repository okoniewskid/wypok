module TextHelper

    def returnHashtags(content)
        content.to_str.gsub(/(<a class=\"hashtag\" href=\"\/hashtags\/.+?\"\> |<\/a>)/) do
            ""
        end
    end
    
    def convertBIUS(content)
        content.to_str.gsub(/(\[\/?(b|i|u|s)\])/) do |match|
            case match
                when "[b]"
                    "<b>"
                when "[i]"
                    "<i>"
                when "[u]"
                    "<u>"
                when "[s]"
                    "<s>"
                when "[/b]"
                    "</b>"
                when "[/i]"
                    "</i>"
                when "[/u]"
                    "</u>"
                else
                    "</s>"
            end
        end
    end
    
    def returnBIUS(content)
        content.to_str.gsub(/\<\/?(b|i|u|s)\>/) do |match|
            case match
                when "<b>"
                    "[b]"
                when "<i>"
                    "[i]"
                when "<u>"
                    "[u]"
                when "<s>"
                    "[s]"
                when "</b>"
                    "[/b]"
                when "</i>"
                    "[/i]"
                when "</u>"
                    "[/u]"
                else
                    "[/s]"
            end
        end
    end
    
    def convertEnter(content)
        content.to_str.gsub(/\n/) do
            '<br>'
        end.html_safe if content.present?
    end
    
    def returnEnter(content)
        content.to_str.gsub(/<\/?br\>/) do
            %(\n)
        end.html_safe if content.present?
    end
    
end
