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
    s = Sedex.create!(name:'Sedex', flat_fee: 50)
    work_order = WorkOrder.create!(street: 'Av Paulista', city: 'São Paulo', state:'SP', number:'10', customer_name:'Mario', 
                                  customer_cpf:'12345678909', customer_phone_numer: '11981232345', total_price:50,
                                  product_name:'Bicicleta', product_weight:5, sku:'123', departure_date:2.days.ago, 
                                  shipping_expected_date:5.days.from_now, warehouse_street:'Rua dos Vianas',
                                  warehouse_city:'São Bernardo do Campo', warehouse_state:'SP', warehouse_number:'234', 
                                  distance:20, shipping_method:s.name, shipping_date: Date.today)
    second_work_order = WorkOrder.create!(street: 'Av Paulista', city: 'São Paulo', state:'SP', number:'10', customer_name:'Mario', 
                        customer_cpf:'12345678909', customer_phone_numer: '11981232345', total_price:50,
                        product_name:'Bicicleta', product_weight:5, sku:'123', departure_date:2.days.ago, 
                        shipping_expected_date:Date.today+5, warehouse_street:'Rua dos Vianas',
                        warehouse_city:'Diadema', warehouse_state:'SP', warehouse_number:'234', 
                        distance:20, shipping_method:s.name, shipping_date: Date.today)                           
    vehicle = Vehicle.create!(brand_name:'Ford', model:'Fiesta', fabrication_year:'2001', full_capacity:100, license_plate:'ABC-1264', 
                              sedex_id: s.id, status:1, work_order_id: second_work_order.id)
    sedex_vehicle = Vehicle.create!(brand_name:'Fiat', model:'Tempra', fabrication_year:'2001', full_capacity:100, license_plate:'ABC-1235', 
                              sedex_id: s.id, status:1, work_order_id: work_order.id)
    
    # Act  
    visit root_path 
    click_on 'Consultar entrega'
    fill_in 'Buscar entrega', with: second_work_order.code
    click_on 'Buscar'
    # Assert 
    expect(page).to have_content "Resultados da busca por: #{second_work_order.code}"
    expect(page).to have_content "Endereço de saída: Rua dos Vianas, 234, Diadema - SP"
    expect(page).to have_content "Endereço de entrega: Av Paulista, 10, São Paulo - SP"
    expect(page).to have_content "Informações do veículo:"
    expect(page).to have_content "Marca: Ford"
    expect(page).to have_content "Modelo: Fiesta"
    expect(page).to have_content "Placa: ABC-1264"
    expect(page).to have_content "Ano de fabricação: 2001"
    expect(page).to have_content "Data de entrega: #{I18n.localize(Date.today)}"
    expect(page).to have_content "Data prevista de entrega: #{I18n.localize(Date.today+5)}"
    expect(page).not_to have_content "São Bernardo do Campo"
    expect(page).not_to have_content "#{work_order.code}"
    expect(page).not_to have_content "Tempra"
  end 
  it 'e não há ordens de serviço com o código pesquisado' do 
    # Arrange 
    s = Sedex.create!(name:'Sedex', flat_fee: 50)
    work_order = WorkOrder.create!(street: 'Av Paulista', city: 'São Paulo', state:'SP', number:'10', customer_name:'Mario', 
                                  customer_cpf:'12345678909', customer_phone_numer: '11981232345', total_price:50,
                                  product_name:'Bicicleta', product_weight:5, sku:'123', departure_date:2.days.ago, 
                                  shipping_expected_date:5.days.from_now, warehouse_street:'Rua dos Vianas',
                                  warehouse_city:'São Bernardo do Campo', warehouse_state:'SP', warehouse_number:'234', 
                                  distance:20, shipping_method:s.name, shipping_date: Date.today)                          
    vehicle = Vehicle.create!(brand_name:'Ford', model:'Fiesta', fabrication_year:'2001', full_capacity:100, license_plate:'ABC-1234', 
                              sedex_id: s.id, status:1, work_order_id: work_order.id)
   
    #Act 
    visit root_path 
    click_on 'Consultar entrega'
    fill_in 'Buscar entrega', with: "#{work_order.code}A"
    click_on 'Buscar'
    
    # Arrange
    expect(page).to have_content "Nenhuma ordem de serviço encontrada."
    expect(page).not_to have_content "São Bernardo do Campo - SP"
    expect(page).not_to have_content "#{work_order.code}"
    expect(page).not_to have_content "Fiesta"
    expect(page).to have_link('Voltar', href: work_orders_path)
  end
  it 'e entrega foi realizada com atraso' do 
    # Arrange 
    s = Sedex.create!(name:'Sedex', flat_fee: 50)
    work_order = WorkOrder.create!(street: 'Av Paulista', city: 'São Paulo', state:'SP', number:'10', customer_name:'Mario', 
                                  customer_cpf:'12345678909', customer_phone_numer: '11981232345', total_price:50,
                                  product_name:'Bicicleta', product_weight:5, sku:'123', departure_date:Date.today-5, 
                                  shipping_expected_date:Date.today-3, warehouse_street:'Rua dos Vianas',
                                  warehouse_city:'São Bernardo do Campo', warehouse_state:'SP', warehouse_number:'234', 
                                  distance:20, shipping_method:s.name, shipping_date: Date.today, status:1)                          
    vehicle = Vehicle.create!(brand_name:'Ford', model:'Fiesta', fabrication_year:'2001', full_capacity:100, license_plate:'ABC-1384', 
                              sedex_id: s.id, status:2, work_order_id: work_order.id)
    user = User.create!(name: 'Maria', email: 'maria@sistemadefrete.com.br', password: '12345678')  

    #Act 
    visit new_user_session_path
    login_as(user)
    visit root_path
    click_on 'Ordens de serviço'
    click_on 'Ver ordens de serviço'
    click_on 'Encerrar ordem de serviço' 
    fill_in 'Motivo do atraso', with: "Enchente"
    click_on 'Encerrar ordem de serviço'
    click_on 'Sair' 
    click_on 'Consultar entrega'
    fill_in 'Buscar entrega', with: "#{work_order.code}"
    click_on 'Buscar'
    
    # Arrange
    expect(page).to have_content "Motivo do atraso"
    expect(page).to have_content "Enchente"
    expect(page).to have_link('Voltar', href: work_orders_path)
    expect(page).to have_content "Data de entrega: #{I18n.localize(Date.today)}"
    expect(page).to have_content "Data prevista de entrega: #{I18n.localize(Date.today-3)}"
    expect(current_path).to eq search_work_orders_path
  end
  it 'e entrega foi realizada dentro do prazo' do 
    # Arrange 
    s = Sedex.create!(name:'Sedex', flat_fee: 50)
    work_order = WorkOrder.create!(street: 'Av Paulista', city: 'São Paulo', state:'SP', number:'10', customer_name:'Mario', 
                                  customer_cpf:'12345678909', customer_phone_numer: '11981232345', total_price:50,
                                  product_name:'Bicicleta', product_weight:5, sku:'123', departure_date:3.days.ago, 
                                  shipping_expected_date:1.day.ago, warehouse_street:'Rua dos Vianas',
                                  warehouse_city:'São Bernardo do Campo', warehouse_state:'SP', warehouse_number:'234', 
                                  distance:20, shipping_method:s.name, shipping_date: Date.today, delay_reason: 'Enchente') 

    second_work_order = WorkOrder.create!(street: 'Av Paulista', city: 'São Paulo', state:'SP', number:'10', customer_name:'Mario', 
                                  customer_cpf:'12345678909', customer_phone_numer: '11981232345', total_price:50,
                                  product_name:'Bicicleta', product_weight:5, sku:'123', departure_date:3.days.ago, 
                                  shipping_expected_date:Date.today+3, warehouse_street:'Rua dos Vianas',
                                  warehouse_city:'São Bernardo do Campo', warehouse_state:'SP', warehouse_number:'234', 
                                  distance:20, shipping_method:s.name, shipping_date: DateTime.now) 

    vehicle = Vehicle.create!(brand_name:'Ford', model:'Fiesta', fabrication_year:'2001', full_capacity:100, license_plate:'ABC-1234', 
                              sedex_id: s.id, status:2, work_order_id: second_work_order.id)
   
    #Act 
    visit root_path 
    click_on 'Consultar entrega'
    fill_in 'Buscar entrega', with: "#{second_work_order.code}"
    click_on 'Buscar'
    
    # Arrange
    expect(page).not_to have_content "Motivo do atraso"
    expect(page).not_to have_content "Enchente"
    expect(page).to have_content "Data de entrega: #{I18n.localize(Date.today)}"
    expect(page).to have_content "Data prevista de entrega: #{I18n.localize(Date.today+3)}"
    expect(current_path).to eq search_work_orders_path
  end
end