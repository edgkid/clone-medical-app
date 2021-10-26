class Offer < ApplicationRecord

    validates :description, :code_offer, :status, :image, presence: true

    validates :description, length: { maximum: 100, message: "Solo se permiten hasta 40 caracteres" }
    validates :code_offer, length: { maximum: 6, message: "Solo se permiten 9 caracteres" }

    validates :description, format: { with: /\A[0-9a-zA-ZÀ-ÿ #-:.;_\s]+\z/, message: "Solo se permiten caracteres numericos" }
    validates :code_offer, format: { with: /\A[0-9a-zA-ZÀ-ÿ\s]+\z/, message: "Solo se permiten caracteres alfabeticos" }

  
end
