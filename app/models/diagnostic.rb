class Diagnostic < ApplicationRecord

    belongs_to :report


    def get_diagnostic_ref (diagnostic_array)

        value = ""

        if diagnostic_array!= nil
            diagnostic_array.each do  |diagnostic|

                value = value + "," + diagnostic
            end
        end

       

        return value

    end

    def save_diagnostic_by_appointment(params)

        if params[:diagnostics] != nil
            params[:diagnostics].each do  |diagnostic|

                value = diagnostic.split("-")
    
                @clinicalDocument = Diagnostic.new(code: value[0], diagnostic: value[1], report: params[:report] )
                 if @clinicalDocument.save(:validate => false)
                    puts "Diagnostico salvado"
                 else
                    puts "Diagnostico no salvado"
                 end
    
            end
        end

        

    end

end
