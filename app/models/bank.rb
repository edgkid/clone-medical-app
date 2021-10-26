class Bank < ApplicationRecord

    validates :name, presence: true

    validates :name, length: { maximum: 40, message: "Solo se permiten 40 caracteres" }

    validates :name, format: { with: /\A[0-9a-zA-ZÀ-ÿ ]+\z/, message: "Solo se permiten caracteres alfanumericos" }

end
