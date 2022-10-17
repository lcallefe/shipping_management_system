# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.sedex_dez)
    WorkOrder.create!(street: 'Av Paulista', city: 'São Paulo', state:'SP', number:'10', customer_name:'Mario', 
    customer_cpf:'12345678909', customer_phone_numer: '11981232345', total_price:50,
    product_name:'Bicicleta', product_weight:5, sku:'123', departure_date:2.days.ago, 
    shipping_expected_date:5.days.from_now, warehouse_street:'Rua dos Vianas',
    warehouse_city:'São Bernardo do Campo', warehouse_state:'SP', warehouse_number:'234', 
    distance:20, shipping_method:'Sedex', shipping_date: Date.today)