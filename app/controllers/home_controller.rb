class HomeController < ApplicationController
  def index

    if user_signed_in?
     
      if current_user.user_type.upcase == "Medico".upcase || current_user.user_type.upcase == "Médico".upcase
        redirect_to '/principalD'
      end

      if current_user.user_type.upcase == "Paciente".upcase
        redirect_to '/principalP'
      end

      if current_user.user_type.upcase == "Root".upcase
        redirect_to '/principalR'
      end

      if current_user.user_type.upcase == "Convenio".upcase
        redirect_to '/principalC'
      end

      if current_user.user_type.upcase == "Caja".upcase
        #redirect_to '/principalB'
        redirect_to '/administracion/aprobar-pago'
      end

      if current_user.user_type.upcase == "Principal".upcase
        redirect_to '/principalA'
      end
    
    else
    
      redirect_to '/users/sign_in'

    end
  end
end
