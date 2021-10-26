class MedicalPlansController < ApplicationController


    def update

        @medical_plan = MedicalPlan.find(params[:id])

        @medical_plan.status = "Revision"
        @medical_plan.payment_type = params[:payment_type]
        @medical_plan.payment_date = Time.now
        @medical_plan.bank_id = params[:bank_id]

        if @medical_plan.update(medical_plan_params)
            redirect_to '/perfilM', notice: "El pago de su plan de suscripción se realizo satisfactoriamente."
        else
            redirect_to '/perfilM', alert: "No se pudo registrar el pago de su plan de suscripción satisfactoriamente."
        end

    end

    def update_root
        
        @medical_plan = MedicalPlan.find(params[:id])

        @medical_plan.status = "Revision"
        @medical_plan.payment_type = params[:payment_type]
        @medical_plan.payment_date = Time.now
        @medical_plan.bank_id = params[:bank_id]

        if @medical_plan.update(medical_plan_params)
            redirect_to '/perfilR', notice: "El pago de su plan de suscripción se realizo satisfactoriamente."
        else
            redirect_to '/perfilR', alert: "No se pudo registrar el pago de su plan de suscripción satisfactoriamente."
        end
        
    end

    private
    def medical_plan_params
      params.permit(:status, :reference_number, :payment_type, :payment_date)
    end

end
