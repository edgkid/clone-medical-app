class MailModifyPasswordMailer < ApplicationMailer

    def mail_modify_password_send(obj)

        @new_passwrod = obj[:password]
        mail to: obj[:user].email, subject: "Nuevo Password - Medi-Chat", from: "example@medi-chat.com"
    end
end
