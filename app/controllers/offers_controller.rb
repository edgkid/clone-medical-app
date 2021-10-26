class OffersController < ApplicationController

    def index
        @offers = Offer.all
        render :index
    end

    def create
        render :new
    end

    def save
        @offer = Offer.new(offer_params)

        if @offer.save 
            redirect_to '/publicidad', notice: "La nueva publicidad se creo de forma satisfactoria."
        else
            redirect_to '/publicidad', alert: "No se pudo guardar el nuevo registro."
        end

    end

    def edit

        @offer = Offer.find(params[:id])
        
        render :edit
    end

    def update
        @offer = Offer.find(params[:id])
        
        if @offer.update(offer_params_edit)
            redirect_to '/publicidad', notice: "El registro se actualizo de forma satisfactoria."
        else
            redirect_to '/publicidad', alert: "El registro no pudo ser actualizado."
        end
    end

    private
    def offer_params
        params.permit(:code_offer, :status, :description, :image)
    end

    def offer_params_edit
        params.require(:offer).permit(:code_offer, :status, :description, :image)
    end
end
