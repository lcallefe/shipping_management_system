# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])

ExpressaDeliveryTimeDistance.destroy_all
ExpressaPriceDistance.destroy_all
ExpressaPriceWeight.destroy_all 

SedexDeliveryTimeDistance.destroy_all
SedexPriceDistance.destroy_all
SedexPriceWeight.destroy_all

SedexDezDeliveryTimeDistance.destroy_all
SedexDezPriceDistance.destroy_all 
SedexDezPriceWeight.destroy_all  

Sedex.destroy_all  
Expressa.destroy_all  
SedexDez.destroy_all  

Vehicle.destroy_all 
User.destroy_all
WorkOrder.destroy_all 

User.create!(name: 'Maria', email: 'maria@sistemadefrete.com.br', password: '12345678')
User.create!(name: 'João', email: 'joão@sistemadefrete.com.br', password: '12345678', admin:true)

e = Expressa.create!(flat_fee:10)

ExpressaDeliveryTimeDistance.create!(min_distance:5, max_distance:10, delivery_time:15)
ExpressaDeliveryTimeDistance.create!(min_distance:11, max_distance:30, delivery_time:35)

ExpressaPriceDistance.create!(min_distance:5, max_distance:15, price:10)
ExpressaPriceDistance.create!(min_distance:16, max_distance:32, price:20)

ExpressaPriceWeight.create!(min_weight:5, max_weight:15, price:1)
ExpressaPriceWeight.create!(min_weight:20, max_weight:23, price:2)

s = Sedex.create!(flat_fee:20) 

SedexDeliveryTimeDistance.create!(min_distance:5, max_distance:100, delivery_time:48)
SedexDeliveryTimeDistance.create!(min_distance:105, max_distance:150, delivery_time:72)

SedexPriceDistance.create!(min_distance:5, max_distance:100, price:20)
SedexPriceDistance.create!(min_distance:105, max_distance:250, price:30)

SedexPriceWeight.create!(min_weight:5, max_weight:20, price:1)
SedexPriceWeight.create!(min_weight:21, max_weight:30, price:2)

sd = SedexDez.create!(flat_fee:25) 

SedexDezDeliveryTimeDistance.create!(min_distance:50, max_distance:100, delivery_time:40)
SedexDezDeliveryTimeDistance.create!(min_distance:200, max_distance:500, delivery_time:80)

SedexDezPriceDistance.create!(min_distance:60, max_distance:100, price:20)
SedexDezPriceDistance.create!(min_distance:200, max_distance:600, price:35)

SedexDezPriceWeight.create!(min_weight:5, max_weight:40, price:1)
SedexDezPriceWeight.create!(min_weight:50, max_weight:80, price:2)

Vehicle.create!(brand_name:'Volvo', model:'1775', fabrication_year:'2001', full_capacity:500, license_plate:'EFJ-1234', 
                sedex_id: 1)
Vehicle.create!(brand_name:'Scania', model:'1234', fabrication_year:'2022', full_capacity:200, license_plate:'HYU-1235', 
                sedex_id: 1)

Vehicle.create!(brand_name:'Volkswagen', model:'Delivery', fabrication_year:'2010', full_capacity:1000, license_plate:'ABC-1236', 
                sedex_dez_id: 1, status:1)
Vehicle.create!(brand_name:'Volvo', model:'FH460', fabrication_year:'2020', full_capacity:800, license_plate:'DEF-1234', 
                sedex_dez_id: 1, status:1)

Vehicle.create!(brand_name:'Mercedes-Benz', model:'Actros 1651', fabrication_year:'2022', full_capacity:500, license_plate:'GHI-1234', 
                expressa_id: 1, status:1)
tempra = Vehicle.create!(brand_name:'Fiat', model:'Tempra', fabrication_year:'1995', full_capacity:100, license_plate:'ABC-1234', 
                         expressa_id: 1, status:1)

Vehicle.create!(brand_name:'Chevrolet', model:'Chevette', fabrication_year:'1992', full_capacity:80, license_plate:'THI-2341', 
                expressa_id: 1, status:0)
vectra = Vehicle.create!(brand_name:'Chevrolet', model:'Vectra', fabrication_year:'1995', full_capacity:100, license_plate:'DBF-5555', 
                         sedex_id: 1, status:2)
peugeot = Vehicle.create!(brand_name:'Peugeot', model:'207-2', fabrication_year:'1995', full_capacity:50, license_plate:'CBD-6666', 
                         sedex_dez_id: 1, status:2)

WorkOrder.create!(street: 'Av Marechal Floriano', city: 'Florianópolis', state:'SC', number:'20', customer_name:'Mario Filho', 
                                       customer_cpf:'12345678909', customer_phone_numer: '11981232345', product_name:'Geladeira', 
                                       product_weight:10, sku:'123', departure_date:Date.today, warehouse_state:'SC', 
                                       warehouse_street:'Rua Lomba do Sabão', warehouse_city:'Florianópolis',  
                                       warehouse_number:'234', distance:5)
WorkOrder.create!(street: 'Rua João Alberto Trevisan', city: 'Poços de Caldas', state:'MG', number:'10', customer_name:'Joaquina', 
                                       customer_cpf:'12345678908', customer_phone_numer: '11981232343', product_name:'Xbox360', 
                                       product_weight:1, sku:'222', departure_date:Date.today, warehouse_state:'SP', 
                                       warehouse_street:'Rua dos Vianas', warehouse_city:'São Bernardo do Campo',  
                                       warehouse_number:'234', distance:1000)
WorkOrder.create!(street: 'Av Paulista', city: 'São Paulo', state:'SP', number:'10', customer_name:'Maria', 
                                       customer_cpf:'12345678903', customer_phone_numer: '11981232345', product_name:'Nintendo Switch', 
                                       product_weight:2, sku:'123', departure_date:Date.today, warehouse_state:'SP', 
                                       warehouse_street:'Av Pereira Barreto', warehouse_city:'São Bernardo do Campo',  
                                       warehouse_number:'500', distance:25)
WorkOrder.create!(street: 'Rua Graciosa', city: 'Diadema', state:'SP', number:'45', customer_name:'Mario Neto', 
                                       customer_cpf:'12345678987', customer_phone_numer: '11981232344', product_name:'Bicicleta', 
                                       product_weight:10, sku:'123', departure_date:Date.today, warehouse_state:'SP', 
                                       warehouse_street:'Av Goias', warehouse_city:'São Caetano do Sul',  
                                       warehouse_number:'9', distance:10)  
WorkOrder.create!(street: 'Av Copacabana', city: 'Rio de Janeiro', state:'RJ', number:'10', customer_name:'Mario Jr', 
                                       customer_cpf:'12345673909', customer_phone_numer: '11981232345', product_name:'Fogão 6 bocas', 
                                       product_weight:40, sku:'AAA', departure_date:Date.today, warehouse_state:'MG', 
                                       warehouse_street:'Av Otacilio Negrão de Lima', warehouse_city:'Belo Horizonte',  
                                       warehouse_number:'234', distance:500)
wo = WorkOrder.create!(street: 'Av Compensa', city: 'Manaus', state:'AM', number:'888', customer_name:'Mario', 
                       customer_cpf:'12345678909', customer_phone_numer: '11981232345', product_name:'Bicicleta', 
                       product_weight:10, sku:'123', departure_date:Date.today, warehouse_state:'SP', 
                       warehouse_street:'Rua dos Vianas', warehouse_city:'São Bernardo do Campo',  
                       warehouse_number:'234', distance:10, status:1)
peugeot.update(work_order_id:wo.id)
sd.update(work_order_id:wo.id)

second_wo = WorkOrder.create!(street: 'Av Paulista', city: 'São Paulo', state:'AC', number:'10', customer_name:'José', 
                              customer_cpf:'12345678909', customer_phone_numer: '11981232345', product_name:'Bicicleta', 
                              product_weight:10, sku:'123', departure_date:Date.today-5, warehouse_state:'SP', 
                              warehouse_street:'Rua dos Vianas', warehouse_city:'São Bernardo do Campo',  
                              warehouse_number:'234', distance:10, status: 3, shipping_date:Date.today, 
                              shipping_expected_date:(Date.today+3), shipping_method:s.name)
vectra.update(work_order_id:second_wo.id)
s.update(work_order_id:second_wo.id)

third_wo = WorkOrder.create!(street: 'Av Paulista', city: 'São Paulo', state:'AC', number:'10', customer_name:'José', 
                             customer_cpf:'12345678909', customer_phone_numer: '11981232345', product_name:'Bicicleta', 
                             product_weight:10, sku:'123', departure_date:(Date.today-5), warehouse_state:'SP', 
                             warehouse_street:'Rua dos Vianas', warehouse_city:'São Bernardo do Campo',  
                             warehouse_number:'234', distance:10, shipping_date:Date.today, 
                             shipping_expected_date:Date.today-3, shipping_method:e.name, status:4) 
tempra.update(work_order_id:third_wo.id)
e.update(work_order_id:third_wo.id)








