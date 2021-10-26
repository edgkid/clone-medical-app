Rails.application.routes.draw do
  # devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  devise_for :users, controllers: { registrations: 'registrations', sessions: 'sessions' }
  get '/solicitar_password', to: 'password_requests#new_password_request'
  post '/salvar_password', to: 'password_requests#save_password_request'


  root 'home#index'
  get '/principalP', to: 'boards#index_patient_board'
  get '/principalD', to: 'boards#index_doctor_board'
  get '/principalR', to: 'boards#index_root_board'
  get '/principalC', to: 'boards#index_convenio'
  get '/principalB', to: 'boards#index_caja'
  get '/principalA', to: 'boards#index_principal_doctor'

  # get '/home', to: 'home#index'

  resources :calls, only: :create do
    collection do
      post 'new', to: 'calls#new'
      post :finish
      post :add_peer
    end
  end

  resources :messages, param: :chat_id, only: %i[index] do
    member do
      # get 'patient/:appointment_id', action: :patient, as: :patient_chat
      # get 'doctor/:appointment_id', action: :doctor, as: :doctor_chat
      post :create
      get :patient
      get :doctor
    end
  end

  resources :chats, only: %i[create]

  resources :appointments, only: %i[index create]

  devise_scope :user do
    get '/users/sign_out' => 'sessions#destroy'
  end

  get '/appointments', to: 'appointments#index'
  get '/admin-appointments', to: 'appointments#index_all'
  get '/patient-appointments', to: 'appointments#index_patient'

  get '/appointments/show/:id', to: 'appointments#show'

  get '/chats', to: 'messages#index'
  post '/new-report-by-Appointment', to: "reports#save"
  post '/new-report-by-Appointment-from-call', to: "reports#save_from_call"
  post '/update-report-by-Appointment/:id', to: "reports#update"
  post '/update-report-by-Appointment-from-call/:id', to: "reports#update_from_call"

  post '/new-clinical-document-by-Appointment', to: "clinical_documents#save"
  post '/new-clinical-document-by-Appointment-from-call', to: "clinical_documents#save_from_call"
  post '/update-clinical-document-by-Appointment/:id', to: "clinical_documents#update"
  post '/update-clinical-document-by-Appointment-from-call/:id', to: "clinical_documents#update_from_call"
  
  post '/new-prescription-by-Appointment', to: "prescriptions#save"
  post '/new-prescription-by-Appointment-from-call', to: "prescriptions#save_from_call"
  post '/update-prescription-by-Appointment/:id', to: "prescriptions#update"
  post '/update-prescription-by-Appointment-from-call/:id', to: "prescriptions#update_from_call"

  get '/list-appointment-by-phone', to: "appointments#list_patients_appointment_call"
  post '/appointment-by-phone', to: "appointments#set_appointment_info"
  get '/appointment-by-phone/:doctor_id/:patient_id/:patient_plan_id', to: "appointments#set_appointment_info"
  post '/appointment-by-phone/new', to: "appointments#save_appointment_info"
  post '/appointment-by-phone/chat', to: "appointments#save_appointment_info_by_chat"


  get '/suscriptions', to: 'plans#index'
  get '/suscriptions/createM', to: 'plans#create_medical_plan'
  post '/suscriptions/saveM', to: 'plans#save_medical_plan'
  post '/suscriptions/saveP', to: 'plans#save_patient_plan'

  get '/print_pdf_report_prescription/:id', to: "reports#print_report_prescription"
  get '/print_pdf_report/:id', to: "reports#print"
  get '/print_pdf_prescription/:id', to: "prescriptions#print"
  get '/print_pdf_paraclinical/:id', to: "clinical_documents#print"
  get '/print_pdf_statistc/:statistc', to: "statistics#print"

  get 'perfilP', to: 'patients#index'
  post 'perfilP', to: 'patients#save'
  post 'perfilP/edit/:id', to: 'patients#update'
  post 'planp/edit/:id', to: 'patient_plans#update'

  get '/indicar-seguro', to: "patients#load_insurance_by_patient"
  post '/indicar-seguro/save', to: "patients#save_insurance_by_patien"

  get 'perfilM', to: 'doctors#index'
  post 'perfilM', to: 'doctors#save'
  post 'perfilM/edit/:id', to: 'doctors#update'
  post 'planm/edit/:id', to: 'medical_plans#update'

  get 'upload_image', to: 'doctors#upload_image'
  post 'upload_image/:id', to: 'doctors#update_with_image'

  #Opciones root
  get 'perfilR', to: 'admins#index'
  post '/perfilR/save', to: 'admins#save'
  post '/perfilR/edit/:id', to: 'admins#update'

  post '/suscriptions/saveR', to: 'plans#save_root_plan'
  post '/planR/edit/:id', to: 'medical_plans#update_root'

  get '/users', to: 'admins#index_users'
  
  get '/administracion/areas', to: 'areas#index'
  get '/administracion/areas/create', to: 'areas#create'
  post '/administracion/areas/new', to: 'areas#save'
  get '/administracion/plans', to: 'plans#index_crud'
  get '/administracion/plans/create', to: 'plans#create'
  post '/administracion/plans/new', to: 'plans#save'
  post '/administracion/areas/active/:id', to: 'areas#set_active_status'
  post '/administracion/plans/active/:id', to: 'plans#set_active_status'
  get '/administracion/areas/update/:id', to: 'areas#edit'
  post '/administracion/areas/edit/:id', to: 'areas#update'
  get '/administracion/plans/update/:id', to: 'plans#edit'
  post '/administracion/planss/edit/:id', to: 'plans#update'

  get '/administracion/carga-masiva', to: 'admins#upload_data_view_patient'
  #post '/administracion/salvado-masiva', to: 'admins#upload_data_save_patient'
  post '/administracion/salvado-masiva-eliminados', to: 'admins#upload_delete_patient'
  post '/administracion/salvado-masiva-activos', to: 'admins#upload_active_patient'
  post '/administracion/salvado-masiva-nuevos', to: 'admins#upload_new_patient'

  get '/administracion/carga-masiva-doctors', to: 'admins#upload_data_view_doctor'
  #post '/administracion/salvado-masiva-doctors', to: 'admins#upload_data_save_doctor'
  post '/administracion/salvado-masiva-doctors-eliminados', to: 'admins#upload_delete_doctor'
  post '/administracion/salvado-masiva-doctors-active', to: 'admins#upload_active_doctor'
  post '/administracion/salvado-masiva-doctors-new', to: 'admins#upload_new_doctor'

  get '/administracion/aprobar-pago', to: 'plans#approve_payment'
  post '/administracion/aprobar-pago/:id', to: 'patient_plans#approve_payment' 

  get '/admin-users', to: 'users#index'
  get '/admin-users/new', to: 'users#create'
  post '/admin-users/new', to: 'users#save'
  get '/admin-users/edit/:id', to: 'users#edit'
  post '/admin-users/edit/:id', to: 'users#update'

  get '/admin-create/doctor', to: "doctors#create_doctor"
  post '/admin-create/doctor/save', to: "doctors#save_doctor"

  get '/admin-doctors', to: "doctors#doctors_created"

  get '/admin-doctors/upload-firm/:id', to: 'doctors#add_firm_by_principal'
  post '/admin-doctors/upload-firm/:id', to: 'doctors#update_with_firm'

  get '/admin-patients', to: "patients#patients_created"
  get '/admin-patients/new', to: "patients#create_patient"
  post '/admin-patients/save', to: "patients#save_patient_by_admin"

  get '/admin-patients/asignar-seguro/:id', to: "patients#load_insurance_by_admin"
  post '/admin-patients/asignar-seguro/save/:id', to: "patients#save_insurance_by_admin"

  get '/admin-banks', to: "banks#index"
  get '/admin-banks/create', to: "banks#create"
  post '/admin-banks/save', to: "banks#save"
  get '/admin-banks/edit/:id', to: "banks#edit"
  post '/admin-banks/update/:id', to: "banks#update"

  #otros perfiles
  get 'perfilB', to: 'admins#index_perfil_B'
  post 'perfilB/save', to: 'admins#save_perfil_B'
  post 'perfilB/edit/:id', to: 'admins#update_perfil_B'

  get 'perfilA', to: 'admins#index_perfil_A'
  post 'perfilA/save', to: 'admins#save_perfil_A'
  post 'perfilA/edit/:id', to: 'admins#update_perfil_A'

  get 'perfilC', to: 'admins#index_perfil_C'
  post 'perfilC/save', to: 'admins#save_perfil_C'
  post 'perfilC/edit/:id', to: 'admins#update_perfil_C'

  get '/admin-insurances', to: 'insurances#index'
  get '/admin-insurances/new', to: 'insurances#create'
  post '/admin-insurances/new', to: 'insurances#save'
  get '/admin-insurances/edit/:id', to: 'insurances#edit'
  post '/admin-insurances/update/:id', to: 'insurances#update'

  get '/admin-reiniciar-passwords', to: 'password_requests#index'
  post '/admin-reiniciar-passwords/save', to:'password_requests#restart_password'

  get '/statistics-particulares-vs-asegurados', to: 'statistics#particular_vs_insurances'
  get '/statistics-particulares-vs-asegurados-por-doctor', to: 'statistics#particular_vs_insurances_by_doctor'
  get '/statistics-pacientes-por-especialidad', to: 'statistics#patient_per_specialty'
  get '/statistics-pacientes-por-doctor', to: 'statistics#patient_per_doctor'
  get '/statistics-pacientes-por-aseguradora', to: 'statistics#patient_per_insurances'
  get '/statistics-pacientes-por-diagnostico', to: 'statistics#patient_per_diagnostic'

  get '/publicidad', to: 'offers#index'
  get '/publicidad/create', to: 'offers#create'
  post '/publicidad/new', to: 'offers#save'
  get '/publicidad/edit/:id', to: 'offers#edit'
  post '/publicidad/update/:id', to: 'offers#update'

  get '/cambiar-password', to: 'users#change_user_password'
  post '/cambiar-password/save', to: 'users#save_change_user_password'

  get  '/enfermedades', to: 'diseases#index'
  get  '/enfermedades/crear', to: 'diseases#create'
  post '/enfermedades/new', to: 'diseases#save'
  get  '/enfermedades/edit/:id', to: 'diseases#edit'
  post '/enfermedades/update/:id', to: 'diseases#update'
  get '/enfermedades/carga-masiva', to: 'diseases#upload_diseases_view'
  post '/enfermedades/carga-masiva/save', to: 'diseases#upload_diseases_action'
end
