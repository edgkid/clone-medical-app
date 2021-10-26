class PlansController < ApplicationController
    
    #para renderizar vista de suscripciones
    def index 
        #@plans = Plan.all
        @plans = Plan.where("status = ? AND type_plan = ?", 'Activo', 'Particular')
        render :index
    end

    #para renderizar vista de curd
    def index_crud

        @plans = Plan.all
        render :index_crud
    end

    def create
        
        render :new
    end

    def save
        @plan = Plan.new(plan_params)

        @plan.status = 'Activo'
        @plan.code = @plan.get_plan_code

        if @plan.validate_name(params[:name]) && @plan.validate_num(params[:cost]) && @plan.validate_num(params[:total_appointments])
            if @plan.save 
                redirect_to '/administracion/plans', notice: "El nuevo plan de suscripción fue guardado satisfactoriamente."
            else
                redirect_to '/administracion/plans', alert: "El nuevo plan de suscripción no pudo ser guardado."
            end
        else

            redirect_to '/administracion/plans/create', alert: "La información ingresada no es valida"

        end

        
    
    end

    def edit
        
        @plan = Plan.find(params[:id])

        render :edit
    end

    def update

        @plan = Plan.find(params[:id])

        if @plan.validate_name(params[:name]) && @plan.validate_num(params[:cost]) && @plan.validate_num(params[:total_appointments])
            
            if  @plan.update( plan_params_edit )
                redirect_to '/administracion/plans', notice: "La infomración del plan de suscripción fue actualizada satisfactoriamente."
            else
                redirect_to '/administracion/plans', alert: "La infomración del plan de suscripción no pudo se actualizada."
            end

        else

            redirect_to "/administracion/plans/update/" + @plan.id.to_s, alert: "La información ingresada no es valida"

        end

        
    
    end

    def set_active_status
        @@status = 'Activo';
        @plan = Plan.find(params[:id])

        if @plan.status.upcase == 'Activo'.upcase
            @@status = 'Inactivo'
        end

        if @plan.update_attribute :status, @@status
            redirect_to '/administracion/plans', notice: "El estatus del plan" + @plan.name + " fue actualizado satisfactoriamente. Nuevo estatus: " + @plan.status
        else
            redirect_to '/administracion/plans', alert: "El estatus del plan" + @plan.name + " no pudo ser actualizado"
        end
    end

    def create_medical_plan
 
        render :create
    end

    def save_medical_plan
        @@total_plans = 0
        @@add_plan = false
        @plan = Plan.find(params[:idPlan])
        @user = User.find(current_user.id)

        @medicalPlan = MedicalPlan.new (medical_plan_params)
        @medicalPlan.plan_id = @plan.id
        @medicalPlan.doctor_id = @user.doctor.id
        @medicalPlan.status='Pendiente'
        @medicalPlan.count = @plan.total_appointments

        @@total_plans = @user.doctor.medical_plans.length

        if @@total_plans == 0
            @@add_plan = true
        end

        if @@total_plans > 0
            
            if @user.doctor.medical_plans[@@total_plans - 1].status.upcase == 'Agotado'.upcase
                @@add_plan = true
            end

        end

        if @@add_plan

            if @medicalPlan.save
                redirect_to '/perfilM'
            else
                redirect_to '/suscriptions', alert: "El nuevo plan de suscripción no pudo ser agregado."
            end
        else
            redirect_to '/suscriptions', notice: "Usted ya posee un plan activo, por lo tanto no se puede agregar un nuevo plan."
        end

    end

    def save_patient_plan
        
        @@add_plan = false
        @plan = Plan.find(params[:idPlan])
        @user = User.find(current_user.id)

        @@total_plans = @plan.plans_by_patient(@user.patient)

        if @@total_plans >= 0 && @@total_plans < 2
            
            @@add_plan = true
            @patientPlan = PatientPlan.new (medical_plan_params)
            @patientPlan.plan_id = @plan.id
            @patientPlan.patient_id = @user.patient.id
            @patientPlan.status = 'Pendiente'
            @patientPlan.type_plan = 'Particular'
            @patientPlan.count = @plan.total_appointments

            if @patientPlan.save
                redirect_to '/perfilP', notice: "Su nuevo plan particular fue agregado con exito."
            else
                redirect_to '/suscriptions', alert: "El nuevo plan de suscripción no pudo ser agregado."
            end

        end
        
        if @@total_plans >= 2
            redirect_to '/suscriptions', alert: "Usted ya posee un plan de consultas particular."
        end

    end

    def save_root_plan
        @@total_plans = 0
        @@add_plan = false
        @plan = Plan.find(params[:idPlan])
        @user = User.find(current_user.id)

        @medicalPlan = MedicalPlan.new (medical_plan_params)
        @medicalPlan.plan_id = @plan.id
        @medicalPlan.doctor_id = @user.doctor.id
        @medicalPlan.status='Pendiente'
        @medicalPlan.count = @plan.total_appointments

        @@total_plans = @user.doctor.medical_plans.length

        if @@total_plans == 0
            @@add_plan = true
        end

        if @@total_plans > 0
            
            if @user.doctor.medical_plans[@@total_plans - 1].status.upcase == 'Agotado'.upcase
                @@add_plan = true
            end

        end

        if @@add_plan

            if @medicalPlan.save
                redirect_to '/perfilR'
            else
                redirect_to '/suscriptions', alert: "El nuevo plan de suscripción no pudo ser agregado."
            end
        else
            redirect_to '/suscriptions', notice: "Usted ya posee un plan activo, por lo tanto no se puede agregar un nuevo plan."
        end

    end


    def approve_payment
        @medical_plans = MedicalPlan.all # probablemente se elimine
        @patient_plans = PatientPlan.all 

        render :approved_payment
    end

    private
    def medical_plan_params
      params.permit(:payment_type, :references_number, :status, :payment_date, :plan_id)
    end

    private
    def plan_params 
        params.permit(:name, :cost, :total_appointments, :type_plan)
    end

    def plan_params_edit 
        params.permit(:name, :cost, :total_appointments,:type_plan)
    end


end
