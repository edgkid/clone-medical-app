# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
a1 = Area.new(name: "Cardeologia", description: "Test", status: "Activo")
a1.save!(:validate => false)
a2 = Area.new(name: "Oftalmologia", description: "Test", status: "Activo")
a2.save!(:validate => false)
a3 = Area.new(name: "Ginecologia", description: "Test", status: "Activo")
a3.save!(:validate => false)
a4 = Area.new(name: "Traumatologia", description: "Test", status: "Activo")
a4.save!(:validate => false)
a5 = Area.new(name: "Administración", description: "Perfiles administrativos", status: "Inactivo")
a5.save!(:validate => false)

p1 = Plan.new(name: "Oro", description:"Plan de prueba de tipo A, plan económico", cost:200.00, total_appointments: 25, status:"Activo", code: "0001", type_plan: "Particular" )
p1.save!(:validate => false)
p2 = Plan.new(name: "Plata", description:"Plan de prueba de tipo B, plan medio", cost:100.00, total_appointments: 15, status:"Activo", code: "0002", type_plan: "Particular") 
p2.save!(:validate => false)
p3 = Plan.new(name: "Bronce", description:"Plan de prueba de tipo C, plan dorado", cost:50.00, total_appointments: 5, status:"Activo", code: "0003", type_plan: "Particular" )
p3.save!(:validate => false)

p4 = Plan.new(name: "Plata - Seguro", description:"Plan de prueba de tipo B, plan medio", cost:100.00, total_appointments: 15, status:"Activo", code: "0002", type_plan: "De Seguro") 
p4.save!(:validate => false)
p5 = Plan.new(name: "Bronce - Seguro", description:"Plan de prueba de tipo C, plan dorado", cost:50.00, total_appointments: 5, status:"Activo", code: "0003", type_plan: "De Seguro" )
p5.save!(:validate => false)

b1 = Bank.new(name: "Banesco C.A", status: "Activo")
b1.save!(:validate => false)
b2 = Bank.new(name: "Mercantil C.A", status: "Activo")
b2.save!(:validate => false)
b3 = Bank.new(name: "100% Banesco C.A", status: "Activo")
b3.save!(:validate => false)

i1 = Insurance.new(name: "Quality Seguros")
i1.save!(:validate => false)
i2 = Insurance.new(name: "mercantil Seguros")
i2.save!(:validate => false)
i3 = Insurance.new(name: "Piramide Seguros")
i3.save!(:validate => false)


u4 = User.new(user_type: "Convenio", email: "convenio@medi-chat.com", password:"123456", status: "Activo", busy: "Ocupado")
u4.save!(:validate => false)
u5 = User.new(user_type: "Caja", email: "caja@medi-chat.com", password:"123456", status: "Activo", busy: "Ocupado")
u5.save!(:validate => false)
u6 = User.new(user_type: "Principal", email: "direccion@medi-chat.com", password:"123456", status: "Activo", busy: "Ocupado")
u6.save!(:validate => false)
u7 = User.new(user_type: "Root", email: "root@medi-chat.com", password:"123456", status: "Activo", busy: "Ocupado")
u7.save!(:validate => false)

Company.create(name: "IBM")
Company.create(name: "Sofcap")
Company.create(name: "Infocent")

Disease.create(diagnostic_code: "M154", diagnostic_des: "(OSTEO) ARTROSIS EROSIVA")
Disease.create(diagnostic_code: "M150", diagnostic_des: "(OSTEO) ARTROSIS PRIMARIA GENERALIZADA")
Disease.create(diagnostic_code: "R100", diagnostic_des: "ABDOMEN AGUDO")
Disease.create(diagnostic_code: "Z939", diagnostic_des: "ABERTURA ARTIFICIAL, NO ESPECIFICADA")
Disease.create(diagnostic_code: "N96",  diagnostic_des: "ABORTADORA HABITUAL")
Disease.create(diagnostic_code: "O035", diagnostic_des: "ABORTO ESPONTANE: COMPLETO O NO ESPECIFICADO; COMPLICADO CON INFECCION GENITAL Y PELVICA")

Disease.create(diagnostic_code: "O037",	diagnostic_des: "ABORTO ESPONTANEO: COMPLETO O NO ESPECIFICADO, COMPLICADO POR EMBOLIA")
Disease.create(diagnostic_code: "O036",	diagnostic_des: "ABORTO ESPONTANEO: COMPLETO O NO ESPECIFICADO, COMPLICADO POR HEMORRAGIA EXCESIVA O TARDIA")
Disease.create(diagnostic_code: "O038",	diagnostic_des: "ABORTO ESPONTANEO: COMPLETO O NO ESPECIFICADO, CON OTRAS COMPLICACIONES ESPECIFICADAS Y LAS NO ESPECIFICADAS")
Disease.create(diagnostic_code: "O039",	diagnostic_des: "ABORTO ESPONTANEO: COMPLETO O NO ESPECIFICADO, SIN COMPLICACION")
Disease.create(diagnostic_code: "O030",	diagnostic_des: "ABORTO ESPONTANEO: INCOMPLETO, COMPLICADO CON INFECCIÓN GENITAL Y PELVIANA")
Disease.create(diagnostic_code: "O032",	diagnostic_des: "ABORTO ESPONTANEO: INCOMPLETO, COMPLICADO POR EMBOLIA")
Disease.create(diagnostic_code: "O031",	diagnostic_des: "ABORTO ESPONTANEO: INCOMPLETO, COMPLICADO POR HEMORRAGIA EXCESIVA O TARDIA")
Disease.create(diagnostic_code: "O033",	diagnostic_des: "ABORTO ESPONTANEO: INCOMPLETO, CON OTRAS COMPLICACIONES ESPECIFICADAS Y LAS NO ESPECIFICADAS")
Disease.create(diagnostic_code: "O034",	diagnostic_des: "ABORTO ESPONTANEO: INCOMPLETO, SIN COMPLICACION")
Disease.create(diagnostic_code: "O045",	diagnostic_des: "ABORTO MEDICO: COMPLETO O NO ESPECIFICADO, COMPLICADO CON INFECCION GENITAL Y PELVIANA")
Disease.create(diagnostic_code: "O047",	diagnostic_des: "ABORTO MEDICO: COMPLETO O NO ESPECIFICADO, COMPLICADO POR EMBOLIA")
Disease.create(diagnostic_code: "O046",	diagnostic_des: "ABORTO MEDICO: COMPLETO O NO ESPECIFICADO, COMPLICADO POR HEMORRAGIA EXCESIVA O TARDIA")
Disease.create(diagnostic_code: "O048",	diagnostic_des: "ABORTO MEDICO: COMPLETO O NO ESPECIFICADO, CON OTRAS COMPLICACIONES ESPECIFICADAS Y LAS NO ESPECIFICADAS")

Disease.create(diagnostic_code: "O049",	diagnostic_des: "ABORTO MEDICO: COMPLETO O NO ESPECIFICADO, SIN COMPLICACION")
Disease.create(diagnostic_code: "O040",	diagnostic_des: "ABORTO MEDICO: INCOMPLETO, COMPLICADO CON INFECCIÓN GENITAL Y PELVIANA")
Disease.create(diagnostic_code: "O042",	diagnostic_des: "ABORTO MEDICO: INCOMPLETO, COMPLICADO POR EMBOLIA")
Disease.create(diagnostic_code: "O041",	diagnostic_des: "ABORTO MEDICO: INCOMPLETO, COMPLICADO POR HEMORRAGIA EXCESIVA O TARDIA")
Disease.create(diagnostic_code: "O043",	diagnostic_des: "ABORTO MEDICO: INCOMPLETO, CON OTRAS COMPLICACIONES ESPECIFICADAS Y LAS NO ESPECIFICADAS")
Disease.create(diagnostic_code: "O044",	diagnostic_des: "ABORTO MEDICO: INCOMPLETO, SIN COMPLICACION")
Disease.create(diagnostic_code: "O065",	diagnostic_des: "ABORTO NO ESPECIFICADO: COMPLETO O NO ESPECIFICADO, COMPLICADO CON INFECCION GENITAL Y PELVIANA")
Disease.create(diagnostic_code: "O067",	diagnostic_des: "ABORTO NO ESPECIFICADO: COMPLETO O NO ESPECIFICADO, COMPLICADO POR EMBOLIA")
Disease.create(diagnostic_code: "O066",	diagnostic_des: "ABORTO NO ESPECIFICADO: COMPLETO O NO ESPECIFICADO, COMPLICADO POR HEMORRAGIA EXCESIVA O TARDIA")
Disease.create(diagnostic_code: "O068",	diagnostic_des: "ABORTO NO ESPECIFICADO: COMPLETO O NO ESPECIFICADO, CON OTRAS COMPLICACIONES ESPECIFICADAS Y LAS NO ESPECIFICADAS")
Disease.create(diagnostic_code: "O069",	diagnostic_des: "ABORTO NO ESPECIFICADO: COMPLETO O NO ESPECIFICADO, SIN COMPLICACION")
Disease.create(diagnostic_code: "O060",	diagnostic_des: "ABORTO NO ESPECIFICADO: INCOMPLETO, COMPLICADO CON INFECCIÓN GENITAL Y PELVIANA")
Disease.create(diagnostic_code: "O062",	diagnostic_des: "ABORTO NO ESPECIFICADO: INCOMPLETO, COMPLICADO POR EMBOLIA")
Disease.create(diagnostic_code: "O061",	diagnostic_des: "ABORTO NO ESPECIFICADO: INCOMPLETO, COMPLICADO POR HEMORRAGIA EXCESIVA O TARDIA")
Disease.create(diagnostic_code: "O063",	diagnostic_des: "ABORTO NO ESPECIFICADO: INCOMPLETO, CON OTRAS COMPLICACIONES ESPECIFICADAS Y LAS NO ESPECIFICADAS")
Disease.create(diagnostic_code: "O064",	diagnostic_des: "ABORTO NO ESPECIFICADO: INCOMPLETO, SIN COMPLICACION")
Disease.create(diagnostic_code: "O021",	diagnostic_des: "ABORTO RETENIDO")
Disease.create(diagnostic_code: "K031",	diagnostic_des: "ABRASION DE LOS DIENTES")
Disease.create(diagnostic_code: "A066",	diagnostic_des: "ABSCESO AMEBIANO DEL CEREBRO (G07*)")
Disease.create(diagnostic_code: "A064",	diagnostic_des: "ABSCESO AMEBIANO DEL HIGADO")
Disease.create(diagnostic_code: "A065",	diagnostic_des: "ABSCESO AMEBIANO DEL PULMON (J99.8*)")
Disease.create(diagnostic_code: "K610",	diagnostic_des: "ABSCESO ANAL")
Disease.create(diagnostic_code: "K612",	diagnostic_des: "ABSCESO ANORRECTAL")
Disease.create(diagnostic_code: "B431",	diagnostic_des: "ABSCESO CEREBRAL FEOMICOTICO")
Disease.create(diagnostic_code: "L023",	diagnostic_des: "ABSCESO CUTANEO, FURUNCULO Y ANTRAX DE GLUTEOS")
Disease.create(diagnostic_code: "L020",	diagnostic_des: "ABSCESO CUTANEO, FURUNCULO Y ANTRAX DE LA CARA")
Disease.create(diagnostic_code: "L021",	diagnostic_des: "ABSCESO CUTANEO, FURUNCULO Y ANTRAX DE LA CUELLO")
Disease.create(diagnostic_code: "L024",	diagnostic_des: "ABSCESO CUTANEO, FURUNCULO Y ANTRAX DE MIEMBRO")
Disease.create(diagnostic_code: "L028",	diagnostic_des: "ABSCESO CUTANEO, FURUNCULO Y ANTRAX DE OTROS SITIOS")
Disease.create(diagnostic_code: "L029",	diagnostic_des: "ABSCESO CUTANEO, FURUNCULO Y ANTRAX DE SITIO NO ESPECIFICADO")
Disease.create(diagnostic_code: "L022",	diagnostic_des: "ABSCESO CUTANEO, FURUNCULO Y ANTRAX DEL TRONCO")
Disease.create(diagnostic_code: "K113",	diagnostic_des: "ABSCESO DE GLANDULA SALIVAL")
Disease.create(diagnostic_code: "M710",	diagnostic_des: "ABSCESO DE LA BOLSA SINOVIAL")
Disease.create(diagnostic_code: "N751",	diagnostic_des: "ABSCESO DE LA GLANDULA DE BARTHOLIN")
Disease.create(diagnostic_code: "O911",	diagnostic_des: "ABSCESO DE LA MAMA ASOCIADO CON EL PARTO")
Disease.create(diagnostic_code: "N412",	diagnostic_des: "ABSCESO DE LA PROSTATA")
Disease.create(diagnostic_code: "M650",	diagnostic_des: "ABSCESO DE VAINA TENDINOSA")
Disease.create(diagnostic_code: "D733",	diagnostic_des: "ABSCESO DEL BAZO")
Disease.create(diagnostic_code: "K750",	diagnostic_des: "ABSCESO DEL HIGADO")
Disease.create(diagnostic_code: "K630",	diagnostic_des: "ABSCESO DEL INTESTINO")
Disease.create(diagnostic_code: "J853",	diagnostic_des: "ABSCESO DEL MEDIASTINO")
Disease.create(diagnostic_code: "H600",	diagnostic_des: "ABSCESO DEL OIDO EXTERNO")
Disease.create(diagnostic_code: "J851",	diagnostic_des: "ABSCESO DEL PULMON CON NEUMONIA")
Disease.create(diagnostic_code: "J852",	diagnostic_des: "ABSCESO DEL PULMON SIN NEUMONIA")
Disease.create(diagnostic_code: "E321",	diagnostic_des: "ABSCESO DEL TIMO")
Disease.create(diagnostic_code: "G062",	diagnostic_des: "ABSCESO EXTRADURAL Y SUBDURAL, NO ESPECIFICADO")
Disease.create(diagnostic_code: "K614",	diagnostic_des: "ABSCESO INTRAESFINTERIANO")
Disease.create(diagnostic_code: "K613",	diagnostic_des: "ABSCESO ISQUIORRECTAL")
Disease.create(diagnostic_code: "J36",	diagnostic_des: "ABSCESO PERIAMIGDALINO")
Disease.create(diagnostic_code: "K046",	diagnostic_des: "ABSCESO PERIAPICAL CON FISTULA")
Disease.create(diagnostic_code: "K047",	diagnostic_des: "ABSCESO PERIAPICAL SIN FISTULA")
Disease.create(diagnostic_code: "K611",	diagnostic_des: "ABSCESO RECTAL")
Disease.create(diagnostic_code: "N151",	diagnostic_des: "ABSCESO RENAL Y PERIRRENAL")
Disease.create(diagnostic_code: "J390",	diagnostic_des: "ABSCESO RETROFARINGEO Y PARAFARINGEO")
Disease.create(diagnostic_code: "N340",	diagnostic_des: "ABSCESO URETRAL")
Disease.create(diagnostic_code: "N764",	diagnostic_des: "ABSCESO VULVAR")
Disease.create(diagnostic_code: "G060",	diagnostic_des: "ABSCESO Y GRANULOMA INTRACRANEAL")
Disease.create(diagnostic_code: "G07*",	diagnostic_des: "ABSCESO Y GRANULOMA INTRACRANEAL E INTRARRAQUIDEO EN ENFERMEDADES CLASIFICADAS EN OTRA PARTE")

Disease.create(diagnostic_code: "G061",	diagnostic_des: "ABSCESO Y GRANULOMA INTRARRAQUIDEO")
Disease.create(diagnostic_code: "B432",	diagnostic_des: "ABSCESO Y QUISTE SUBCUTANEO FEOMICOTICO")
Disease.create(diagnostic_code: "J340",	diagnostic_des: "ABSCESO, FURUNCULO Y ANTRAX DE LA NARIZ")
Disease.create(diagnostic_code: "F55",	diagnostic_des: "ABUSO DE SUSTANCIAS QUE NO PRODUCEN DEPENDENCIA")
Disease.create(diagnostic_code: "T741",	diagnostic_des: "ABUSO FISICO")
Disease.create(diagnostic_code: "T743",	diagnostic_des: "ABUSO PSICOLOGICO")
Disease.create(diagnostic_code: "T742",	diagnostic_des: "ABUSO SEXUAL")
Disease.create(diagnostic_code: "K220",	diagnostic_des: "ACALASIA DEL CARDIAS")
Disease.create(diagnostic_code: "B601",	diagnostic_des: "ACANTAMEBIASIS")
Disease.create(diagnostic_code: "L83",	diagnostic_des: "ACANTOSIS NIGRICANS")
Disease.create(diagnostic_code: "V959",	diagnostic_des: "ACCIDENTE DE AERONAVE NO ESPECIFICADA, CON OCUPANTE LESIONADO")
Disease.create(diagnostic_code: "V969",	diagnostic_des: "ACCIDENTE DE AERONAVE SIN MOTOR NO ESPECIFICADA, CON OCUPANTE LESIONADO")
Disease.create(diagnostic_code: "V961",	diagnostic_des: "ACCIDENTE DE ALA DELTA, CON OCUPANTE LESIONADO")
Disease.create(diagnostic_code: "V906",	diagnostic_des: "ACCIDENTE DE EMBARCACION QUE CAUSA AHOGAMIENTO Y SUMERSION: BALSA INFLABLE (SIN MOTOR)")
Disease.create(diagnostic_code: "V901",	diagnostic_des: "ACCIDENTE DE EMBARCACION QUE CAUSA AHOGAMIENTO Y SUMERSION: BARCO DE PASAJEROS")
Disease.create(diagnostic_code: "V900",	diagnostic_des: "ACCIDENTE DE EMBARCACION QUE CAUSA AHOGAMIENTO Y SUMERSION: BARCO MERCANTE")
Disease.create(diagnostic_code: "V902",	diagnostic_des: "ACCIDENTE DE EMBARCACION QUE CAUSA AHOGAMIENTO Y SUMERSION: BOTE DE PESCA")
Disease.create(diagnostic_code: "V905",	diagnostic_des: "ACCIDENTE DE EMBARCACION QUE CAUSA AHOGAMIENTO Y SUMERSION: CANOA O KAYAK")
Disease.create(diagnostic_code: "V907",	diagnostic_des: "ACCIDENTE DE EMBARCACION QUE CAUSA AHOGAMIENTO Y SUMERSION: ESQUI ACUATICO")
Disease.create(diagnostic_code: "V903",	diagnostic_des: "ACCIDENTE DE EMBARCACION QUE CAUSA AHOGAMIENTO Y SUMERSION: OTRO VEHICULO ACUATICO CON MOTOR")
Disease.create(diagnostic_code: "V908",	diagnostic_des: "ACCIDENTE DE EMBARCACION QUE CAUSA AHOGAMIENTO Y SUMERSION: OTRO VEHICULO ACUATICO SIN MOTOR")
Disease.create(diagnostic_code: "V909",	diagnostic_des: "ACCIDENTE DE EMBARCACION QUE CAUSA AHOGAMIENTO Y SUMERSION: VEHICULO ACUATICO NO ESPECIFICADO")
Disease.create(diagnostic_code: "V904",	diagnostic_des: "ACCIDENTE DE EMBARCACION QUE CAUSA AHOGAMIENTO Y SUMERSION: VELERO")
Disease.create(diagnostic_code: "V916",	diagnostic_des: "ACCIDENTE DE EMBARCACION QUE CAUSA OTROS TIPOS DE TRAUMATISMO: BALSA INFLABLE (SIN MOTOR)")
Disease.create(diagnostic_code: "V911",	diagnostic_des: "ACCIDENTE DE EMBARCACION QUE CAUSA OTROS TIPOS DE TRAUMATISMO: BARCO DE PASAJEROS")
Disease.create(diagnostic_code: "V910",	diagnostic_des: "ACCIDENTE DE EMBARCACION QUE CAUSA OTROS TIPOS DE TRAUMATISMO: BARCO MERCANTE")
Disease.create(diagnostic_code: "V912",	diagnostic_des: "ACCIDENTE DE EMBARCACION QUE CAUSA OTROS TIPOS DE TRAUMATISMO: BOTE DE PESCA")
Disease.create(diagnostic_code: "V915",	diagnostic_des: "ACCIDENTE DE EMBARCACION QUE CAUSA OTROS TIPOS DE TRAUMATISMO: CANOA O KAYAK")
Disease.create(diagnostic_code: "V917",	diagnostic_des: "ACCIDENTE DE EMBARCACION QUE CAUSA OTROS TIPOS DE TRAUMATISMO: ESQUI ACUATICO")
Disease.create(diagnostic_code: "V913",	diagnostic_des: "ACCIDENTE DE EMBARCACION QUE CAUSA OTROS TIPOS DE TRAUMATISMO: OTRO VEHICULO ACUATICO CON MOTOR")
Disease.create(diagnostic_code: "V918",	diagnostic_des: "ACCIDENTE DE EMBARCACION QUE CAUSA OTROS TIPOS DE TRAUMATISMO: OTRO VEHICULO ACUATICO SIN MOTOR")
Disease.create(diagnostic_code: "V919",	diagnostic_des: "ACCIDENTE DE EMBARCACION QUE CAUSA OTROS TIPOS DE TRAUMATISMO: VEHICULO ACUATICO NO ESPECIFICADO")
Disease.create(diagnostic_code: "V914",	diagnostic_des: "ACCIDENTE DE EMBARCACION QUE CAUSA OTROS TIPOS DE TRAUMATISMO: VELERO")
Disease.create(diagnostic_code: "V960",	diagnostic_des: "ACCIDENTE DE GLOBO AEROSTATICO, CON OCUPANTE LESIONADO")
Disease.create(diagnostic_code: "V950",	diagnostic_des: "ACCIDENTE DE HELICOPTERO CON OCUPANTE LESIONADO")
Disease.create(diagnostic_code: "V954",	diagnostic_des: "ACCIDENTE DE NAVE ESPACIAL, CON OCUPANTE LESIONADO")
Disease.create(diagnostic_code: "V968",	diagnostic_des: "ACCIDENTE DE OTRAS AERONAVES SIN MOTOR, CON OCUPANTE LESIONADO")
Disease.create(diagnostic_code: "V958",	diagnostic_des: "ACCIDENTE DE OTRAS AERONAVES, CON OCUPANTE LESIONADO")

Disease.create(diagnostic_code: "V952",	diagnostic_des: "ACCIDENTE DE OTROS VEHICULOS AEREOS DE ALAS FIJAS, PRIVADOS, CON OCUPANTE LESIONADO")
Disease.create(diagnostic_code: "V962",	diagnostic_des: "ACCIDENTE DE PLANEADOR (SIN MOTOR), CON OCUPANTE LESIONADO")
Disease.create(diagnostic_code: "V951",	diagnostic_des: "ACCIDENTE DE PLANEADOR ULTRA LIVIANO, MICRO LIVIANO O MOTORIZADO, CON OCUPANTE LESIONADO")
Disease.create(diagnostic_code: "V99",	diagnostic_des: "ACCIDENTE DE TRANSPORTE NO ESPECIFICADO")
Disease.create(diagnostic_code: "V953",	diagnostic_des: "ACCIDENTE DE VEHICULO AEREO DE ALAS FIJAS, COMERCIAL, CON OCUPANTE LESIONADO")
Disease.create(diagnostic_code: "V936",	diagnostic_des: "ACCIDENTE EN UNA EMBARCACION, SIN ACCIDENTE A LA EMBARCACION, QUE NO CAUSA AHOGAMIENTO O SUMERSION: BALSA INFLABLE (SIN MOTOR)")
Disease.create(diagnostic_code: "V931",	diagnostic_des: "ACCIDENTE EN UNA EMBARCACION, SIN ACCIDENTE A LA EMBARCACION, QUE NO CAUSA AHOGAMIENTO O SUMERSION: BARCO DE PASAJEROS")
Disease.create(diagnostic_code: "V930",	diagnostic_des: "ACCIDENTE EN UNA EMBARCACION, SIN ACCIDENTE A LA EMBARCACION, QUE NO CAUSA AHOGAMIENTO O SUMERSION: BARCO MERCANTE")
Disease.create(diagnostic_code: "V932",	diagnostic_des: "ACCIDENTE EN UNA EMBARCACION, SIN ACCIDENTE A LA EMBARCACION, QUE NO CAUSA AHOGAMIENTO O SUMERSION: BOTE DE PESCA")
Disease.create(diagnostic_code: "V935",	diagnostic_des: "ACCIDENTE EN UNA EMBARCACION, SIN ACCIDENTE A LA EMBARCACION, QUE NO CAUSA AHOGAMIENTO O SUMERSION: CANOA O KAYAK")
Disease.create(diagnostic_code: "V937",	diagnostic_des: "ACCIDENTE EN UNA EMBARCACION, SIN ACCIDENTE A LA EMBARCACION, QUE NO CAUSA AHOGAMIENTO O SUMERSION: ESQUI ACUATICO")
Disease.create(diagnostic_code: "V933",	diagnostic_des: "ACCIDENTE EN UNA EMBARCACION, SIN ACCIDENTE A LA EMBARCACION, QUE NO CAUSA AHOGAMIENTO O SUMERSION: OTRO VEHICULO ACUATICO CON MOTOR")
Disease.create(diagnostic_code: "V938",	diagnostic_des: "ACCIDENTE EN UNA EMBARCACION, SIN ACCIDENTE A LA EMBARCACION, QUE NO CAUSA AHOGAMIENTO O SUMERSION: OTRO VEHICULO ACUATICO SIN MOTOR")
Disease.create(diagnostic_code: "V939",	diagnostic_des: "CCIDENTE EN UNA EMBARCACION, SIN ACCIDENTE A LA EMBARCACION, QUE NO CAUSA AHOGAMIENTO O SUMERSION: VEHICULO ACUATICO NO ESPECIFICADO")
Disease.create(diagnostic_code: "V934",	diagnostic_des: "ACCIDENTE EN UNA EMBARCACION, SIN ACCIDENTE A LA EMBARCACION, QUE NO CAUSA AHOGAMIENTO O SUMERSION: VELERO")
Disease.create(diagnostic_code: "I64",	diagnostic_des: "ACCIDENTE VASCULAR ENCEFALICO AGUDO, NO ESPECIFICADO COMO HEMORRAGICO O ISQUEMICO")
Disease.create(diagnostic_code: "R824", diagnostic_des: "ACETONURIA")
Disease.create(diagnostic_code: "R12",	diagnostic_des: "ACIDEZ")
Disease.create(diagnostic_code: "E872",	diagnostic_des: "ACIDOSIS")
Disease.create(diagnostic_code: "P740",	diagnostic_des: "ACIDOSIS METABOLICA TARDIA DEL RECIEN NACIDO")
Disease.create(diagnostic_code: "L701",	diagnostic_des: "ACNE CONGLOBADO")
Disease.create(diagnostic_code: "L705",	diagnostic_des: "ACNE EXCORIADO DE LA MUJER JOVEN")
Disease.create(diagnostic_code: "L704",	diagnostic_des: "ACNE INFANTIL")
Disease.create(diagnostic_code: "L730",	diagnostic_des: "ACNE QUELOIDE")
Disease.create(diagnostic_code: "L703",	diagnostic_des: "ACNE TROPICAL")
Disease.create(diagnostic_code: "L702",	diagnostic_des: "ACNE VARIOLIFORME")
Disease.create(diagnostic_code: "L700",	diagnostic_des: "ACNE VULGAR")
Disease.create(diagnostic_code: "L709",	diagnostic_des: "ACNE, NO ESPECIFICADO")
Disease.create(diagnostic_code: "Q770",	diagnostic_des: "ACONDROGENESIS")
Disease.create(diagnostic_code: "Q774",	diagnostic_des: "ACONDROPLASIA")
Disease.create(diagnostic_code: "M670",	diagnostic_des: "CORTAMIENTO DEL TENDON DE AQUILES (ADQUIRIDO)")
Disease.create(diagnostic_code: "L402",	diagnostic_des: "ACRODERMATITIS CONTINUA")
Disease.create(diagnostic_code: "L904",	diagnostic_des: "ACRODERMATITIS CRONICA ATROFICA")
Disease.create(diagnostic_code: "L444",	diagnostic_des: "ACRODERMATITIS PAPULAR INFANTIL [GIANNOTTI-CROSTI]")
Disease.create(diagnostic_code: "E220",	diagnostic_des: "ACROMEGALIA Y GIGANTISMO HIPOFISARIO")
Disease.create(diagnostic_code: "B471",	diagnostic_des: "ACTINOMICETOMA")
Disease.create(diagnostic_code: "A421",	diagnostic_des: "ACTINOMICOSIS ABDOMINAL")
Disease.create(diagnostic_code: "A422",	diagnostic_des: "ACTINOMICOSIS CERVICOFACIAL")
Disease.create(diagnostic_code: "A420",	diagnostic_des: "ACTINOMICOSIS PULMONAR")
Disease.create(diagnostic_code: "A429",	diagnostic_des: "ACTINOMICOSIS, SIN OTRA ESPECIFICACION")
Disease.create(diagnostic_code: "F422",	diagnostic_des: "ACTOS E IDEAS OBSESIVAS MIXTOS")

Disease.create(diagnostic_code: "R591",	diagnostic_des: "ADENOMEGALIA GENERALIZADA")
Disease.create(diagnostic_code: "R590",	diagnostic_des: "ADENOMEGALIA LOCALIZADA")
Disease.create(diagnostic_code: "R599",	diagnostic_des: "ADENOMEGALIA, NO ESPECIFICADA")
Disease.create(diagnostic_code: "B970",	diagnostic_des: "ADENOVIRUS COMO CAUSA DE ENFERMEDADES CLASIFICADAS EN OTROS CAPITULOS")
Disease.create(diagnostic_code: "K565",	diagnostic_des: "ADHERENCIAS [BRIDAS] INTESTINALES CON OBSTRUCCION")
Disease.create(diagnostic_code: "K660",	diagnostic_des: "ADHERENCIAS PERITONEALES")
Disease.create(diagnostic_code: "N994",	diagnostic_des: "ADHERENCIAS PERITONEALES PELVICAS CONSECUTIVAS A PROCEDIMIENTOS")
Disease.create(diagnostic_code: "736",	diagnostic_des: "ADHERENCIAS PERITONEALES PELVICAS FEMENINAS")
Disease.create(diagnostic_code: "N992",	diagnostic_des: "ADHERENCIAS POSTOPERATORIAS DE LA VAGINA")
Disease.create(diagnostic_code: "Z506",	diagnostic_des: "ADIESTRAMIENTO ORTOPTICO")
Disease.create(diagnostic_code: "E65",	diagnostic_des: "ADIPOSIDAD LOCALIZADA")
Disease.create(diagnostic_code: "H270",	diagnostic_des: "AFAQUIA")
Disease.create(diagnostic_code: "Q123",	diagnostic_des: "AFAQUIA CONGENITA")
Disease.create(diagnostic_code: "F803",	diagnostic_des: "AFASIA ADQUIRIDA CON EPILEPSIA [LANDAU-KLEFFNER]")
Disease.create(diagnostic_code: "L539",	diagnostic_des: "AFECCION ERITEMATOSA, NO ESPECIFICADA")
Disease.create(diagnostic_code: "D699",	diagnostic_des: "AFECCION HEMORRAGICA, NO ESPECIFICADA")
Disease.create(diagnostic_code: "P839",	diagnostic_des: "AFECCION NO ESPECIFICADA DE LA PIEL, PROPIAS DEL FETO Y DEL RECIEN NACIDO")
Disease.create(diagnostic_code: "P969",	diagnostic_des: "AFECCION NO ESPECIFICADA ORIGINADA EN EL PERIODO PERINATAL")
Disease.create(diagnostic_code: "Y95",	diagnostic_des: "AFECCION NOSOCOMIAL")
Disease.create(diagnostic_code: "J949",	diagnostic_des: "AFECCION PLEURAL, NO ESPECIFICADA")
Disease.create(diagnostic_code: "Y96",	diagnostic_des: "AFECCION RELACIONADA CON EL TRABAJO")
Disease.create(diagnostic_code: "Y98",	diagnostic_des: "AFECCION RELACIONADA CON ESTILO DE VIDA")
Disease.create(diagnostic_code: "Y97",	diagnostic_des: "AFECCION RELACIONADA CON LA CONTAMINACION AMBIENTAL")
Disease.create(diagnostic_code: "P289",	diagnostic_des: "AFECCION RESPIRATORIA NO ESPECIFICADA DEL RECIEN NACIDO")
Disease.create(diagnostic_code: "J689",	diagnostic_des: "AFECCION RESPIRATORIA NO ESPECIFICADA, DEBIDA A INHALACION DE GASES, HUMOS, VAPORES Y SUSTANCIAS QUIMICAS")
Disease.create(diagnostic_code: "J840",	diagnostic_des: "AFECCIONES ALVEOLARES Y ALVEOLOPARIETALES")
Disease.create(diagnostic_code: "H445",	diagnostic_des: "AFECCIONES DEGENERATIVAS DEL GLOBO OCULAR")
Disease.create(diagnostic_code: "H052",	diagnostic_des: "AFECCIONES EXOFTALMICAS")
Disease.create(diagnostic_code: "K102",	diagnostic_des: "AFECCIONES INFLAMATORIAS DE LOS MAXILARES")
Disease.create(diagnostic_code: "N949",	diagnostic_des: "AFECCIONES NO ESPECIFICADAS ASOCIADAS CON LOS ORGANOS GENITALES FEMENINOS Y EL CICLO MENSTRUAL")
Disease.create(diagnostic_code: "H611",	diagnostic_des: "AFECCIONES NO INFECCIOSAS DEL PABELLON AUDITIVO")
Disease.create(diagnostic_code: "J684",	diagnostic_des: "AFECCIONES RESPIRATORIAS CRONICAS DEBIDAS A INHALACION DE GASES, HUMOS, VAPORES Y SUSTANCIAS QUIMICAS")
Disease.create(diagnostic_code: "J709",	diagnostic_des: "AFECCIONES RESPIRATORIAS DEBIDAS A AGENTES EXTERNOS NO ESPECIFICADOS")
Disease.create(diagnostic_code: "J708",	diagnostic_des: "AFECCIONES RESPIRATORIAS DEBIDAS A OTROS AGENTES EXTERNOS ESPECIFICADOS")
Disease.create(diagnostic_code: "R491",	diagnostic_des: "AFONIA")
Disease.create(diagnostic_code: "O923",	diagnostic_des: "AGALACTIA")
Disease.create(diagnostic_code: "Q333",	diagnostic_des: "AGENESIA DEL PULMON")
Disease.create(diagnostic_code: "Q624",	diagnostic_des: "AGENESIA DEL URETER")
Disease.create(diagnostic_code: "Q301",	diagnostic_des: "AGENESIA O HIPOPLASIA DE LA NARIZ")
Disease.create(diagnostic_code: "Q601",	diagnostic_des: "AGENESIA RENAL, BILATERAL")
Disease.create(diagnostic_code: "Q602",	diagnostic_des: "AGENESIA RENAL, SIN OTRA ESPECIFICACIÓN")
Disease.create(diagnostic_code: "Q600",	diagnostic_des: "AGENESIA RENAL, UNILATERAL")
Disease.create(diagnostic_code: "Q515",	diagnostic_des: "AGENESIA Y APLASIA DEL CUELLO UTERINO")
Disease.create(diagnostic_code: "Q510",	diagnostic_des: "AGENESIA Y APLASIA DEL UTERO")
Disease.create(diagnostic_code: "Q440",	diagnostic_des: "AGENESIA, APLASIA E HIPOPLASIA DE LA VESICULA BILIAR")
Disease.create(diagnostic_code: "Q450",	diagnostic_des: "AGENESIA, APLASIA E HIPOPLASIA DEL PANCREAS")
Disease.create(diagnostic_code: "R481",	diagnostic_des: "AGNOSIA")
Disease.create(diagnostic_code: "F400",	diagnostic_des: "AGORAFOBIA")
Disease.create(diagnostic_code: "T733",	diagnostic_des: "AGOTAMIENTO DEBIDO A ESFUERZO EXCESIVO")
Disease.create(diagnostic_code: "T732",	diagnostic_des: "AGOTAMIENTO DEBIDO A EXPOSICION A LA INTEMPERIE")
Disease.create(diagnostic_code: "T674",	diagnostic_des: "AGOTAMIENTO POR CALOR DEBIDO A DEPLECION DE SAL")
Disease.create(diagnostic_code: "T675",	diagnostic_des: "AGOTAMIENTO POR CALOR NO ESPECIFICADO")
Disease.create(diagnostic_code: "T673",	diagnostic_des: "AGOTAMIENTO POR CALOR, ANHIDROTICO")
Disease.create(diagnostic_code: "Q845",	diagnostic_des: "AGRANDAMIENTO E HIPERTROFIA DE LAS UÑAS")
Disease.create(diagnostic_code: "D70",	diagnostic_des: "AGRANULOCITOSIS")
Disease.create(diagnostic_code: "X936",	diagnostic_des: "AGRESION CON DISPARO DE ARMA CORTA: AREA INDUSTRIAL Y DE LA CONSTRUCCION")
Disease.create(diagnostic_code: "X933",	diagnostic_des: "AGRESION CON DISPARO DE ARMA CORTA: AREAS DE DEPORTE Y ATLETISMO")
Disease.create(diagnostic_code: "X934",	diagnostic_des: "AGRESION CON DISPARO DE ARMA CORTA: CALLES Y CARRETERAS")
Disease.create(diagnostic_code: "X935",	diagnostic_des: "AGRESION CON DISPARO DE ARMA CORTA: COMERCIO Y AREAS DE SERVICIO")
Disease.create(diagnostic_code: "X932",	diagnostic_des: "AGRESION CON DISPARO DE ARMA CORTA: ESCUELAS, OTRAS INSTITUCIONES Y AREAS ADMINISTRATIVAS PUBLICAS")
Disease.create(diagnostic_code: "X937",	diagnostic_des: "AGRESION CON DISPARO DE ARMA CORTA: GRANJA")
Disease.create(diagnostic_code: "X931",	diagnostic_des: "AGRESION CON DISPARO DE ARMA CORTA: INSTITUCION RESIDENCIAL")
Disease.create(diagnostic_code: "X939",	diagnostic_des: "AGRESION CON DISPARO DE ARMA CORTA: LUGAR NO ESPECIFICADO")
Disease.create(diagnostic_code: "X938",	diagnostic_des: "AGRESION CON DISPARO DE ARMA CORTA: OTRO LUGAR ESPECIFICADO")
Disease.create(diagnostic_code: "X930",	diagnostic_des: "AGRESION CON DISPARO DE ARMA CORTA: VIVIENDA")
Disease.create(diagnostic_code: "X956",	diagnostic_des: "AGRESION CON DISPARO DE OTRAS ARMAS DE FUEGO, Y LAS NO ESPECIFICADAS: AREA INDUSTRIAL Y DE LA CONSTRUCCION")
Disease.create(diagnostic_code: "X953",	diagnostic_des: "AGRESION CON DISPARO DE OTRAS ARMAS DE FUEGO, Y LAS NO ESPECIFICADAS: AREAS DE DEPORTE Y ATLETISMO")
Disease.create(diagnostic_code: "X954",	diagnostic_des: "AGRESION CON DISPARO DE OTRAS ARMAS DE FUEGO, Y LAS NO ESPECIFICADAS: CALLES Y CARRETERAS")
Disease.create(diagnostic_code: "X955",	diagnostic_des: "AGRESION CON DISPARO DE OTRAS ARMAS DE FUEGO, Y LAS NO ESPECIFICADAS: COMERCIO Y AREAS DE SERVICIO")
Disease.create(diagnostic_code: "X952",	diagnostic_des: "AGRESION CON DISPARO DE OTRAS ARMAS DE FUEGO, Y LAS NO ESPECIFICADAS: ESCUELAS, OTRAS INSTITUCIONES Y AREAS ADMINISTRATIVAS PUBLICAS")
Disease.create(diagnostic_code: "X957",	diagnostic_des: "AGRESION CON DISPARO DE OTRAS ARMAS DE FUEGO, Y LAS NO ESPECIFICADAS: GRANJA")
Disease.create(diagnostic_code: "X951",	diagnostic_des: "AGRESION CON DISPARO DE OTRAS ARMAS DE FUEGO, Y LAS NO ESPECIFICADAS: INSTITUCION RESIDENCIAL")
Disease.create(diagnostic_code: "X959",	diagnostic_des: "AGRESION CON DISPARO DE OTRAS ARMAS DE FUEGO, Y LAS NO ESPECIFICADAS: LUGAR NO ESPECIFICADO")
Disease.create(diagnostic_code: "X958",	diagnostic_des: "AGRESION CON DISPARO DE OTRAS ARMAS DE FUEGO, Y LAS NO ESPECIFICADAS: OTRO LUGAR ESPECIFICADO")
Disease.create(diagnostic_code: "X950",	diagnostic_des: "AGRESION CON DISPARO DE OTRAS ARMAS DE FUEGO, Y LAS NO ESPECIFICADAS: VIVIENDA")
Disease.create(diagnostic_code: "X946",	diagnostic_des: "AGRESION CON DISPARO DE RIFLE, ESCOPETA Y ARMA LARGA: AREA INDUSTRIAL Y DE LA CONSTRUCCION")
Disease.create(diagnostic_code: "X943",	diagnostic_des: "AGRESION CON DISPARO DE RIFLE, ESCOPETA Y ARMA LARGA: AREAS DE DEPORTE Y ATLETISMO")
Disease.create(diagnostic_code: "X944",	diagnostic_des: "AGRESION CON DISPARO DE RIFLE, ESCOPETA Y ARMA LARGA: CALLES Y CARRETERAS")
Disease.create(diagnostic_code: "X945",	diagnostic_des: "AGRESION CON DISPARO DE RIFLE, ESCOPETA Y ARMA LARGA: COMERCIO Y AREAS DE SERVICIO")
Disease.create(diagnostic_code: "X942",	diagnostic_des: "AGRESION CON DISPARO DE RIFLE, ESCOPETA Y ARMA LARGA: ESCUELAS, OTRAS INSTITUCIONES Y AREAS ADMINISTRATIVAS PUBLICAS")
Disease.create(diagnostic_code: "X947",	diagnostic_des: "AGRESION CON DISPARO DE RIFLE, ESCOPETA Y ARMA LARGA: GRANJA")
Disease.create(diagnostic_code: "X941",	diagnostic_des: "AGRESION CON DISPARO DE RIFLE, ESCOPETA Y ARMA LARGA: INSTITUCION RESIDENCIAL")
Disease.create(diagnostic_code: "X949",	diagnostic_des: "AGRESION CON DISPARO DE RIFLE, ESCOPETA Y ARMA LARGA: LUGAR NO ESPECIFICADO")
Disease.create(diagnostic_code: "X948",	diagnostic_des: "AGRESION CON DISPARO DE RIFLE, ESCOPETA Y ARMA LARGA: OTRO LUGAR ESPECIFICADO")
Disease.create(diagnostic_code: "X940",	diagnostic_des: "AGRESION CON DISPARO DE RIFLE, ESCOPETA Y ARMA LARGA: VIVIENDA")
Disease.create(diagnostic_code: "X856",	diagnostic_des: "AGRESION CON DROGAS, MEDICAMENTOS Y SUSTANCIAS BIOLOGICAS: AREA INDUSTRIAL Y DE LA CONSTRUCCION")
Disease.create(diagnostic_code: "X853",	diagnostic_des: "AGRESION CON DROGAS, MEDICAMENTOS Y SUSTANCIAS BIOLOGICAS: AREAS DE DEPORTE Y ATLETISMO")
Disease.create(diagnostic_code: "X854",	diagnostic_des: "AGRESION CON DROGAS, MEDICAMENTOS Y SUSTANCIAS BIOLOGICAS: CALLES Y CARRETERAS")
Disease.create(diagnostic_code: "X855",	diagnostic_des: "AGRESION CON DROGAS, MEDICAMENTOS Y SUSTANCIAS BIOLOGICAS: COMERCIO Y AREAS DE SERVICIO")
