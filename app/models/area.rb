class Area < ApplicationRecord

    validates :name, :description, presence: true

    validates :name, length: { maximum: 40,  message: "Solo se permiten 30 caracteres" }
    validates :description, length: { maximum: 100,  message: "Solo se permiten 100 caracteres" }
    validates :name, :description, format: { with: /\A[a-zA-ZÀ-ÿ\-#_,;.:()0-9 ]+\z/, message: "No se permiten caracteres especiales, solo; # _ - ; . : , ()"  }

    has_many :doctors
end
