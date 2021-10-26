class SessionsController < Devise::SessionsController

  def create
    super
    
    @user = User.where("email = ?", current_user.email)
    #@user[0].login_status = 'Login'
    
    @user[0].update_attribute :login_status, 'Login'
    #case params[:email]
    #when 'doctor@med.com'
     # redirect_to doctor_messages_path
    #when 'paciente@med.com' 
     # redirect_to index_path
    #else
     # flash[:error] = 'Email y contraseña no coinciden'
      #render :login, layout: 'session'
    #end
  end

  def destroy
    #super
    @user = User.where("email = ?", current_user.email)
    @user[0].update_attribute :login_status, 'Logout'
    super
    #redirect_to '/users/sign_in'
  end
  
end
