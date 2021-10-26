class UsersController < ApplicationController

    def index
        if current_user.user_type == "Principal"
            @users = User.where("user_type = 'Medico'")
        end

        if current_user.user_type == "Convenio"
            @users = User.where("user_type = 'Paciente'")
        end

        if current_user.user_type == "Root"
            @users = User.all
        end

        render :index
    end

    def create
    
        render :create
    end

    def save
       
        @user = User.new

        if User.exists?( email: params[:email])
            redirect_to '/admin-users/new', alert: "la cuenta de usuario ya esta en uso"
        else
            #
            if @user.validate_empty_valiue ({email: params[:email], type: params[:type]})

                @user = User.new(user_type: params[:type], email: params[:email], password: "medi-chat123", status: "Activo", busy: "Ocupado")
        
                if @user.save!(:validate => false)
                    redirect_to '/admin-users', notice: "El usuaio fue crado con exito."
                else
                    redirect_to '/admin-users', alert: " El usuario no pudo ser creado."
                end
        

            else
                redirect_to '/admin-users/new', alert: "llene todos los campos"
            end
        end

        

    end

    def edit
        
        @user = User.find(params[:id])
    
        render :edit
    end

    def update
        
        @user = User.find(params[:id])

        if  @user.update(user_params)
            redirect_to '/admin-users', notice: "La información de usario fue actualizada satisfactoriamente."
        else
            redirect_to '/admin-users', alert: "La información de usuario no pudo ser actualizada."
        end
        
    end

    def change_user_password
    
        render :change_password
    end

    def save_change_user_password

        have_password = false
        have_confirm = false

        @user = User.where("email = ?", current_user.email)

        if params[:password_confirmation] != nil && params[:password_confirmation] != ""
            have_confirm = true
        end

        if params[:password] != nil && params[:password] != ""
            have_password = true
        end
            
        if have_confirm && have_password
            
            if params[:password_confirmation] == params[:password]

                if @user[0].get_password_size(params[:password]) >= 6 

                    if @user[0].update_attribute(:password, params[:password])
                        redirect_to destroy_user_session_path
                    else
                        redirect_to '/cambiar-password', alert: "Su nuevo password no pudo ser actualizado."
                    end
                
                else
                    redirect_to '/cambiar-password', alert: "Sus password debe poseer entre 6 y 20 caracteres."
                end

                
                
            else
                redirect_to '/cambiar-password', alert: "Sus password no coinciden."
            end

        else
            redirect_to '/cambiar-password', alert: "Indique nuevo password."
        end

    end

    private
    def user_params
        params.require(:user).permit(:login_status, :user_type, :email, :status, :busy)
    end

end
