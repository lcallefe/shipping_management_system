require 'rails_helper'

describe 'Usuário busca por uma ordem de serviço a partir da tela inicial' do 
  it 'e não está autenticado' do 
    # Arrange

    # Act
    visit root_path
    click_on 'Consultar entrega'
    # Assert
    expect(page).to have_field('Buscar entrega')
    expect(page).to have_button('Buscar')
  end
  it 'e está autenticado' do 
    # Arrange 
    user = User.create!(name:'Luciana', email: 'luciana@sistemadefrete.com.br', password: 'password')
    # Act 
    visit new_user_session_path
    login_as(user)
    visit root_path
    # Assert
    expect(page).not_to have_field('Buscar entrega')
    expect(page).not_to have_button('Buscar')
  end
  it 'e encontra uma ordem de serviço' do
    # Arrange  
    sm = Sedex.create!(name:'Sedex', flat_fee: 50)
    work_order = WorkOrder.create!(street: 'Av Paulista', city: 'São Paulo', state:'SP', number:'10', customer_name:'Mario', 
                                  customer_cpf:'12345678909', customer_phone_numer: '11981232345', total_price:50,
                                  product_name:'Bicicleta', product_weight:5, sku:'123', departure_date:2.days.ago, 
                                  shipping_expected_date:5.days.from_now, warehouse_street:'Rua dos Vianas',
                                  warehouse_city:'São Bernardo do Campo', warehouse_state:'SP', warehouse_number:'234', 
                                  distance:20, shipping_method:sm.name, shipping_date: Date.today)
    second_work_order = WorkOrder.create!(street: 'Av Paulista', city: 'São Paulo', state:'SP', number:'10', customer_name:'Mario', 
                        customer_cpf:'12345678909', customer_phone_numer: '11981232345', total_price:50,
                        product_name:'Bicicleta', product_weight:5, sku:'123', departure_date:2.days.ago, 
                        shipping_expected_date:5.days.from_now, warehouse_street:'Rua dos Vianas',
                        warehouse_city:'Diadema', warehouse_state:'SP', warehouse_number:'234', 
                        distance:20, shipping_method:sm.name, shipping_date: Date.today)  
    third_work_order =  WorkOrder.create!(street: 'Av Paulista', city: 'Ribeirão Pires', state:'SP', number:'10', customer_name:'Mario', 
                        customer_cpf:'12345678909', customer_phone_numer: '11981232345', total_price:50,
                        product_name:'Bicicleta', product_weight:5, sku:'123', departure_date:2.days.ago, 
                        shipping_expected_date:5.days.from_now, warehouse_street:'Rua dos Vianas',
                        warehouse_city:'São Caetano do Sul', warehouse_state:'SP', warehouse_number:'234', 
                        distance:20, shipping_method:sm.name, shipping_date: Date.today)                             
    vehicle = Vehicle.create!(brand_name:'Ford', model:'Fiesta', fabrication_year:'2001', full_capacity:100, license_plate:'ABC-1234', 
                              sedex_id: sm.id, status:1, work_order_id: work_order.id)
    second_vehicle = Vehicle.create!(brand_name:'Fiat', model:'Tempra', fabrication_year:'2001', full_capacity:100, license_plate:'ABC-1234', 
                              sedex_id: sm.id, status:1, work_order_id: second_work_order.id)
    third_vehicle =  Vehicle.create!(brand_name:'Chevrolet', model:'Chevette', fabrication_year:'2001', full_capacity:100, license_plate:'ABC-1234', 
                              sedex_id: sm.id, status:1, work_order_id: second_work_order.id)

    # Act  
    visit root_path 
    click_on 'Consultar entrega'
    fill_in 'Buscar entrega', with: work_order.code
    click_on 'Buscar'
    # Assert 
    expect(page).to have_content "Resultados da busca por: #{work_order.code}"
    expect(page).to have_content "Endereço de saída: Rua dos Vianas, 234, São Bernardo do Campo - SP "
    expect(page).to have_content "Endereço de entrega: Av Paulista, 10, São Paulo - SP "
    expect(page).to have_content "Informações do veículo:"
    expect(page).to have_content "Marca: Ford"
    expect(page).to have_content "Modelo: Fiesta"
    expect(page).to have_content "Placa: ABC-1234"
    expect(page).to have_content "Ano de fabricação: 2001"
    expect(page).to have_content "Data de entrega: #{I18n.localize(Date.today)}"
    expect(page).to have_content "Data prevista de entrega: #{I18n.localize(Date.today+5)}"
    expect(page).not_to have_content "Diadema"
    expect(page).not_to have_content "Ribeirão Pires"
    expect(page).not_to have_content "#{second_work_order.code}"
    expect(page).not_to have_content "#{third_work_order.code}"
    expect(page).not_to have_content "Tempra"
    expect(page).not_to have_content "Chevette"
  end 
  it 'e não há ordens de serviço com o código pesquisado' do 
    # Arrange 
    sm = Sedex.create!(name:'Sedex', flat_fee: 50)
    work_order = WorkOrder.create!(street: 'Av Paulista', city: 'São Paulo', state:'SP', number:'10', customer_name:'Mario', 
                                  customer_cpf:'12345678909', customer_phone_numer: '11981232345', total_price:50,
                                  product_name:'Bicicleta', product_weight:5, sku:'123', departure_date:2.days.ago, 
                                  shipping_expected_date:5.days.from_now, warehouse_street:'Rua dos Vianas',
                                  warehouse_city:'São Bernardo do Campo', warehouse_state:'SP', warehouse_number:'234', 
                                  distance:20, shipping_method:sm.name, shipping_date: Date.today)                          
    vehicle = Vehicle.create!(brand_name:'Ford', model:'Fiesta', fabrication_year:'2001', full_capacity:100, license_plate:'ABC-1234', 
                              sedex_id: sm.id, status:1, work_order_id: work_order.id)
   
    #Act 
    visit root_path 
    click_on 'Consultar entrega'
    fill_in 'Buscar entrega', with: "#{work_order.code}A"
    click_on 'Buscar'
    
    # Arrange
    expect(page).to have_content "Nenhum pedido encontrado"
    expect(page).not_to have_content "São Bernardo do Campo - SP"
    expect(page).not_to have_content "#{work_order.code}"
    expect(page).not_to have_content "Fiesta"
    expect(current_path).to eq search_work_orders_path
  end
end