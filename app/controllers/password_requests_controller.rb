class PasswordRequestsController < ApplicationController

    def index
        @request = PasswordRequest.where("status = ?", "Por Actualizar")
        render :index
    end

    def new_password_request
        render :request_new_password 
    end

    def save_password_request

        @password_requests = PasswordRequest.new(user_name: params[:user_name], status: "Por Actualizar")

        if @password_requests.user_exis(params[:user_name])
    
            if @password_requests.if_send_request (params[:user_name])
                redirect_to '/solicitar_password', notice: "La solicitud ya fue enviada."
            else
                if @password_requests.save
                    redirect_to '/solicitar_password', notice: "Su solicitud fue enviada con exito, espere ser contactado."
                else
                    redirect_to '/solicitar_password', alert: "Por ahora no es posible generar la solicitud."
                end
            end

        else
            puts "El usuario no existe"
            redirect_to '/solicitar_password', alert: "El usuario indicado no existe."
        end

    end

    def restart_password 
        
        updated_password = false
        @password_requests = PasswordRequest.new()
        
        @user = User.where("email = ?", params[:user_name])

        updated_password = @password_requests.updated_password(@user[0])

        if updated_password
            redirect_to '/admin-reiniciar-passwords', notice: "El password se reinicio de forma exitosa."
        else
            redirect_to '/admin-reiniciar-passwords', alert: "El password no pudo ser restablecido."
        end
        #if @user[0].update_attribute :password, "medi-chat123"

           # @request = PasswordRequest.where("user_name = ?", params[:user_name])
          #  @request[0].update_attribute :status, "Actualizado"
         #   redirect_to '/admin-reiniciar-passwords', notice: "El password se reinicio de forma exitosa."
        #else
         #   redirect_to '/admin-reiniciar-passwords', alert: "El password no pudo ser restablecido."
        #end

    end

    private
    def params_passowrd_request
      params.permit(:user_name)
    end
    
end
