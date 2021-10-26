class BanksController < ApplicationController

    def index
        
        @banks = Bank.all
        render :index
    end

    def create
        render :new
    end

    def save 

        @bank = Bank.new(bank_params)

        if @bank.save 
            redirect_to '/admin-banks', notice: "La entidad se creo de forma satisfactoria."
        else
            redirect_to '/admin-banks', alert: "No se pudo el nuevo registro."
        end
    
    end

    def edit 
        
        @bank = Bank.find(params[:id])
        render :edit
    end

    def update

        @bank = Bank.find(params[:id])
        
        if @bank.update(bank_params)
            redirect_to '/admin-banks', notice: "El registro de entidad d epago se actualizo de forma satisfactoria."
        else
            redirect_to '/admin-banks', alert: "El registro no pudo ser actualizado."
        end

    end

    private
    def bank_params
      params.permit(:name, :status)
    end

end
