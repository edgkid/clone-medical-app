class InsurancesController < ApplicationController
    
    def index
        @insurances = Insurance.all

        render :index
    end

    def create

      render :new
    end

    def save

      @insurance = Insurance.new(insurance_params_save)

      if @insurance.save
        redirect_to '/admin-insurances', notice: "El nuevo seguro fue registrado satisfactoriamente."
      else
        redirect_to '/admin-insurances', alert: "No se pudo registrar el nuevo seguro satisfactoriamente."
      end

    end

    def edit

      @insurance = Insurance.find(params[:id])

      render :edit
    end

    def update

      @insurance = Insurance.find(params[:id])

      if @insurance.update(insurance_params_edit)
        redirect_to '/admin-insurances', notice: "La información de seguro fue actualizada satisfactoriamente."
      else
        redirect_to '/admin-insurances', alert: "No se pudo actualizar la información seguro satisfactoriamente."
      end

    end

    private
    def insurance_params_edit
      params.permit(:name)
    end

    private
    def insurance_params_save
      params.permit(:name)
    end
end
