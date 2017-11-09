module ApplicationHelper
    def bootstrap_class_for flash_type
        case flash_type
            when :success
                "alert-success"
            when :error
                "alert-error"
            when :alert
                "alert-block"
            when :notice
                "alert-info"
            else
                flash_type.to_s
        end
    end
    
    def display_avatar(user)  
        unless user.avatar.nil? 
            image_tag(user.avatar.file_name) 
        else
            image_tag("default.png")
        end    
    end
    
end
