require 'rails_helper'

describe 'Usuário inicia uma ordem de serviço' do
  it 'com sucesso' do
    # Arrange
    work_order = WorkOrder.create!(street: 'Av Paulista', city: 'São Paulo', state:'SP', number:'10', customer_name:'Mario', 
      customer_cpf:'12345678909', customer_phone_numer: '11981232345',
      product_name:'Bicicleta', product_weight:5, sku:'123', departure_date:2.days.ago, 
      shipping_expected_date:5.days.from_now, warehouse_street:'Rua dos Vianas',
      warehouse_city:'São Bernardo do Campo', warehouse_state:'SP', warehouse_number:'234', 
      distance:11)
    s = Sedex.create!(name:'Sedex', flat_fee: 50)
    sd = SedexDez.create!(name:'Sedex Dez', flat_fee: 50, work_order_id: work_order.id)
    user = User.create!(name: 'Maria', email: 'maria@sistemadefrete.com.br', password: '12345678')  
    SecondPriceDistance.delete_all
    SecondDeliveryTimeDistance.delete_all 
    SecondPriceWeight.delete_all 
    ThirdPriceDistance.delete_all 
    ThirdDeliveryTimeDistance.delete_all 
    ThirdPriceWeight.delete_all
    sedex_distance_price = SecondPriceDistance.create!(min_distance:5, max_distance:10, price:30, sedex_id:s.id)
    sedex_delivery_time = SecondDeliveryTimeDistance.create!(min_distance:5, max_distance:10, delivery_time:72, sedex_id:s.id)
    sedex_price_weight = SecondPriceWeight.create!(min_weight:10, max_weight:25, price:30, sedex_id:s.id)
    sedex_dez_distance_price = FirstPriceDistance.create!(min_distance:5, max_distance:15, price:70, sedex_dez_id:sd.id)
    sedex_dez_delivery_time = FirstDeliveryTimeDistance.create!(min_distance:5, max_distance:15, delivery_time:72, sedex_dez_id:sd.id) 
    sedex_dez_price_weight = FirstPriceWeight.create!(min_weight:5, max_weight:15, price:70, sedex_dez_id:sd.id) 
    Vehicle.create!(brand_name:'Ford', model:'Fiesta', fabrication_year:'2001', full_capacity:100, license_plate:'ABC-1234', 
                    sedex_dez_id: s.id, status:1, work_order_id: work_order.id)
    
    # Act
    visit new_user_session_path
    login_as(user)  #work_order_shipping_method_sedex_dez
    visit root_path
    click_on 'Ordens de serviço'
    click_on 'Ver ordens de serviço'
    click_on 'Inicializar ordem de serviço'
    click_on 'Salvar'
    # Assert
    expect(page).to have_content 'Ordem de serviço iniciada com sucesso.'
    expect(page).to have_link('Sair', href: destroy_user_session_path)
    expect(page).to have_content "#{work_order.code}"
    expect(current_path).to eq pending_work_orders_path
  end
  it 'e não há modalidades de entrega disponíveis' do
    # Arrange
    user = User.create!(name: 'Maria', email: 'maria@sistemadefrete.com.br', password: '12345678', admin:true)
    work_order = WorkOrder.create!(street: 'Av Paulista', city: 'São Paulo', state:'SP', number:'10', customer_name:'Mario', 
                                   customer_cpf:'12345678909', customer_phone_numer: '11981232345', total_price:50,
                                   product_name:'Bicicleta', product_weight:5, sku:'123', departure_date:2.days.ago, 
                                   shipping_expected_date:5.days.from_now, warehouse_street:'Rua dos Vianas',
                                   warehouse_city:'São Bernardo do Campo', warehouse_state:'SP', warehouse_number:'234', 
                                   distance:10, shipping_method:nil, shipping_date: nil)
    # Act
    login_as(user)
    visit root_path
    click_on 'Ordens de serviço'
    click_on 'Ver ordens de serviço'
    click_on 'Inicializar ordem de serviço'
 
    # Assert
    expect(page).to have_content 'Não há modalidades de entrega disponíveis.'
    expect(page).not_to have_content 'Preço'
    expect(page).not_to have_content 'Prazo'
    expect(page).to have_link('Sair', href: destroy_user_session_path)
    expect(current_path).to eq edit_work_order_path(work_order.id)
  end
  it 'e volta para a tela de ordens de serviço' do
    # Arrange
    user = User.create!(name: 'Maria', email: 'maria@sistemadefrete.com.br', password: '12345678', admin:true)
    work_order = WorkOrder.create!(street: 'Av Paulista', city: 'São Paulo', state:'SP', number:'10', customer_name:'Mario', 
                                   customer_cpf:'12345678909', customer_phone_numer: '11981232345', total_price:50,
                                   product_name:'Bicicleta', product_weight:5, sku:'123', departure_date:2.days.ago, 
                                   shipping_expected_date:5.days.from_now, warehouse_street:'Rua dos Vianas',
                                   warehouse_city:'São Bernardo do Campo', warehouse_state:'SP', warehouse_number:'234', 
                                   distance:10, shipping_method:nil, shipping_date: nil)
    # Act
    login_as(user)
    visit root_path
    click_on 'Ordens de serviço'
    click_on 'Ver ordens de serviço'
    click_on 'Inicializar ordem de serviço'
    click_on 'Voltar'
 
    # Assert
    expect(page).to have_content 'Pendente'
    expect(page).not_to have_content 'Em Progresso'
    expect(page).to have_content "#{work_order.code}"
    expect(page).to have_link('Inicializar ordem de serviço')
  end
end