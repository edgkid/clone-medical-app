class Report < ApplicationRecord

    belongs_to :appointment

    has_many :diagnostics

end
