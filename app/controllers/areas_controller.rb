class AreasController < ApplicationController


    def index 
        @areas = Area.all

        render :index
    end

    def create
    
        render :new
    end

    def save 
        
        @area = Area.new(area_params)

        @area.status = 'Activo'

        if @area.save 
            redirect_to '/administracion/areas', notice: "La nueva área fue guardada satisfactoriamente."
        else
            redirect_to '/administracion/areas', alert: "La nueva área no pudo ser guardada."
        end

    end

    def edit
        
        @area = Area.find(params[:id])

        render :edit
    end

    def update 

        @area = Area.find(params[:id])

        puts "Edicion"
        puts area_params
        puts [:name]
        puts [:description]

        if  @area.update(area_params_edit)
            redirect_to '/administracion/areas', notice: "La información del área fue actualizada satisfactoriamente."
        else
            redirect_to '/administracion/areas', alert: "La información del área no pudo ser actualizada."
        end
    
    end

    def set_active_status
        @@status = 'Activo';
        @area = Area.find(params[:id])

        if @area.status.upcase == 'Activo'.upcase
            @@status = 'Inactivo'
        end

        if @area.update_attribute :status, @@status
            redirect_to '/administracion/areas', notice: "El estatus del área" + @area.name + " fue actualizado satisfactoriamente. Nuevo estatus: " + @area.status
        else
            redirect_to '/administracion/areas', alert: "El estatus del área no pudo ser actualizado satisfactoriamente."
        end
    end

    private
    def area_params
      params.permit(:name, :description)
    end

    def area_params_edit
        params.permit(:name, :description)
      end
  

end
