class DiseasesController < ApplicationController

    def index

        @diagnostics = Disease.all
        render :index
    end
    
    def create
        
        @disease = Disease.new
        render :create

    end

    def save 

        @disease = Disease.new(disease_params)

        if Disease.exists?(diagnostic_code: @disease.diagnostic_code)
            redirect_to '/enfermedades/crear', alert: "El código de impresión diagnostica ya existe."
        else

            if @disease.save 
                redirect_to '/enfermedades', notice: "La entidad se creo de forma satisfactoria."
            else
                redirect_to '/enfermedades/crear', alert: "Problemas para crear el nuevo registro, verifique los campos."
            end
        
        end

    end

    def edit 

        @disease = Disease.find(params[:id])
        render :edit

    end

    def update

        @disease = Disease.find(params[:id])

        if Disease.exists?(diagnostic_code: params[:diagnostic_code])
            redirect_to '/enfermedades/edit/' + @disease.id.to_s, alert: "El código de impresión diagnóstica ya existe."
        else

            if @disease.update(disease_params)
                redirect_to '/enfermedades', notice: "Los datos se actualizaron de forma satisfactoria."
            else
                redirect_to '/enfermedades/edit/' + @disease.id.to_s, alert: "Problemas para crear el nuevo registro, verifique los campos."
            end

        end


    end

    def upload_diseases_view

        @disease = Disease.all
        render :upload
    end

    def upload_diseases_action

        procesed = false
        name = params[:name].split(".")[0]
        @disease = Disease.new

        if name === "Diagnosticos"

            array_object = @disease.get_list_diagnostic_by_csv({file: params[:file_name]})      
            procesed = @disease.save_diagnostic_by_csv({array_object: array_object}) 

            if procesed[:value_bool]
                redirect_to '/enfermedades/carga-masiva', notice: " El archivo CSV fue procesado satisfactoriamente, registros procesados = " + procesed[:total_saved].to_s + " no procesados = " + procesed[:total_unsaved].to_s
            else
                redirect_to '/enfermedades/carga-masiva', alert: " Los registros del CSV no fueron cargados, los mismos ya existen. total de registros = " + procesed[:total_unsaved].to_s
             end


        else
            redirect_to '/enfermedades/carga-masiva', alert: "Por favor cargue el archivo correspondiente con los diagnósticos (Diagnosticos.csv)."
        end

    end

    private
    def disease_params
        params.permit(:diagnostic_code, :diagnostic_des)
    end


end
