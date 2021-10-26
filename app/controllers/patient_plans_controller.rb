class PatientPlansController < ApplicationController

    def update

        @patient_plan = PatientPlan.find(params[:id])

        @patient_plan.status = "Revision"
        @patient_plan.payment_type = params[:payment_type]
        @patient_plan.payment_date = Time.now
        @patient_plan.bank_id = params[:bank_id]
        @patient_plan.payment_to = params[:payment_to]

        if @patient_plan.update(patient_plan_params)
            redirect_to '/perfilP', notice: "El pago de su plan de suscripción se realizo satisfactoriamente."
        else
            redirect_to '/perfilP', alert: "No se pudo registrar el pago de su plan de suscripción satisfactoriamente."
        end

    end

    def approve_payment
        
        puts "Parametros " + params[:idPlan].to_s + " " + params[:status]
        
        @patient_plan = PatientPlan.find(params[:idPlan])
        @patient_plan.status = params[:status]
        
        

        if @patient_plan.update(patient_plan_params)
            redirect_to '/administracion/aprobar-pago', notice: "El pago del plan fue actualizado satisfactoriamente."
        else
            redirect_to '/administracion/aprobar-pago', alert: "El pago del plan no se pudo actualizar demanera exitosa. "
        end
    
    end

    private
    def patient_plan_params
      params.permit(:status, :reference_number, :payment_type, :payment_date, :payment_to)
    end

end
