class Disease < ApplicationRecord

    validates :diagnostic_code, :diagnostic_des, presence: true

    validates :diagnostic_code, length: { maximum: 5, message: "Solo se permiten 5 caracteres" }
    validates :diagnostic_des, length: { maximum: 200, message: "Solo se permiten 200 caracteres" }
   
    validates :diagnostic_code, format: { with: /\A[0-9a-zA-ZÀ-ÿ *"()#-:.;_\s]+\z/, message: "Solo se permiten caracteres alfa-númericos  y" }
    validates :diagnostic_des, format: { with: /\A[0-9a-zA-ZÀ-ÿ #()*"-:.;_\s]+\z/, message: "Solo se permiten caracteres alfa-númericos  y" }
    
    def get_list_diagnostic_by_csv(file)

        size_array = 0
        row=0
        col = 0
        array_object = []
        next_string = ""
        
        base64_string_decode_content_file = Base64.decode64(file[:file])
        base64_string_decode_content_file.force_encoding(Encoding::UTF_8)

        array_content_file = base64_string_decode_content_file.gsub(', ','. ').gsub("\n",',').split(',')
        size_array = array_content_file.length

        while row < size_array do
            
        
            if array_content_file[col + 1] == nil
                break;
            end
        
            @object_diseases = {
                diagnostic_code: array_content_file[col].gsub('"',''),
                diagnostic_des: array_content_file[col + 1].gsub('"','')

            }
            
            array_object.push(@object_diseases)
            row = row + 2
            col = col + 2
        end

        return array_object 
     
    end


    def save_diagnostic_by_csv(obj)

        array_bool_values = []
        register_saved = 0
        register_unsaved = 0
        value_bool = false

        obj[:array_object].each do |diagnostic|
            
            if Disease.exists?(diagnostic_code: diagnostic[:diagnostic_code])

                array_bool_values.push(false)
            else
                
                @disease = Disease.new( diagnostic_code: diagnostic[:diagnostic_code], diagnostic_des: diagnostic[:diagnostic_des] )
                
                if @disease.save!(:validate => false)
                    array_bool_values.push(true)
                else
                    array_bool_values.push(false)
                end

            end

        end

        array_bool_values.each do |procesed|
        
            if procesed
                register_saved = register_saved + 1 
            else
                register_unsaved = register_unsaved + 1
            end

        end

        if register_saved != 0
            value_bool = true
        end
        
        return {value_bool: value_bool, total_saved: register_saved, total_unsaved: register_unsaved}
    
    end

    

end
