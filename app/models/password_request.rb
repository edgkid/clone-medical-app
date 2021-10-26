class PasswordRequest < ApplicationRecord

    #after_update :update_password
    
    def updated_password(user)

        value = false
        password = "medi-chat123"

        if user.update_attribute :password, password
            
            @request = PasswordRequest.where("user_name = ?", user.email)
            @request[0].update_attribute :status, "Actualizado"
            value = true

        end

        #MailModifyPasswordMailer.mail_modify_password_send(self).deliver
        MailModifyPasswordMailer.mail_modify_password_send({user: user, password: password}).deliver

        return value
    
    end

    def user_exis(user)
        
        @user = User.where("email = ?", user)

        if @user.size > 0
            return true
        else
            return false
        end
    
    end

    def if_send_request(user)
        @request = PasswordRequest.where("user_name = ?", user)

        if @request.size > 0
            return true
        else
            return false
        end

    end

end
