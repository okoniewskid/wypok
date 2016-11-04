class Emoticoner
    ICONS = {
    :smile => {:string => [":)", ";)["], :icon => "smile.png"},
    :happy => {:string => [":D", ";D", ":d", ";d"], :icon => "happy.png"},
    :sad => {:string => [":(", ";("], :icon => "sad.png"},
    :tongue => {:string => [":p", ";p", ":P", ";P"], :icon => "tongue.png"},
    }

    PATH = '/images/emoticons'

    def self.emoticate(msg)
        ICONS.each do |name, row_data|
            row_data[:string].each do |ico|
                msg = msg.gsub(ico, "<img src=\"#{PATH}/#{row_data[:icon]}\" alt=\"\" />")
            end
        end
        msg
    end
end 