require 'rails_helper'

describe 'Usuário encerra uma ordem de serviço' do
  it 'dentro do prazo com sucesso' do
    # Arrange
    user = User.create!(name: 'Maria', email: 'maria@sistemadefrete.com.br', password: '12345678')  
    work_order = WorkOrder.create!(street: 'Av Paulista', city: 'São Paulo', state:'SP', number:'10', customer_name:'Mario', 
      customer_cpf:'12345678909', customer_phone_numer: '11981232345',
      product_name:'Bicicleta', product_weight:5, sku:'123', departure_date:2.days.ago, 
      shipping_expected_date:5.days.from_now, warehouse_street:'Rua dos Vianas',
      warehouse_city:'São Bernardo do Campo', warehouse_state:'SP', warehouse_number:'234', 
      distance:11, shipping_date:Date.today, shipping_method:'Sedex', status:1)
    Expressa.create!(flat_fee:10)
    Sedex.create!(flat_fee:50)
    SedexDez.create!(flat_fee:10)
    Vehicle.create!(brand_name:'Ford', model:'Fiesta', fabrication_year:'2001', full_capacity:100, license_plate:'ABC-1234', 
                    sedex_id: 1, status:2, work_order_id: work_order.id)
    
    # Act
    visit new_user_session_path
    login_as(user)  
    visit root_path
    click_on 'Ordens de serviço'
    click_on 'Ver ordens de serviço'
    click_on 'Encerrar ordem de serviço'
    click_on 'Encerrar ordem de serviço'
    # Assert
    expect(page).to have_content 'Ordem de serviço encerrada com sucesso.'
    expect(page).to have_link('Sair', href: destroy_user_session_path)
    expect(current_path).to eq pending_work_orders_path
  end

  it 'fora do prazo com sucesso' do
    # Arrange
    user = User.create!(name: 'Maria', email: 'maria@sistemadefrete.com.br', password: '12345678')  
    work_order = WorkOrder.create!(street: 'Av Paulista', city: 'São Paulo', state:'SP', number:'10', customer_name:'Mario', 
      customer_cpf:'12345678909', customer_phone_numer: '11981232345',
      product_name:'Bicicleta', product_weight:5, sku:'123', departure_date:4.days.ago, 
      shipping_expected_date:3.day.ago, warehouse_street:'Rua dos Vianas',
      warehouse_city:'São Bernardo do Campo', warehouse_state:'SP', warehouse_number:'234', 
      distance:11, shipping_method:'Sedex', status:1, shipping_date:Date.today)
    Vehicle.create!(brand_name:'Ford', model:'Fiesta', fabrication_year:'2001', full_capacity:100, license_plate:'ABC-1234', 
        sedex_id: 1, status:2, work_order_id: work_order.id)
    
    # Act
    visit new_user_session_path
    login_as(user)
    visit root_path
    click_on 'Ordens de serviço'
    click_on 'Ver ordens de serviço'
    click_on 'Encerrar ordem de serviço' 
    fill_in 'Motivo do atraso', with: "Acidente de trânsito"
    click_on 'Encerrar ordem de serviço'

    # Assert
    expect(page).to have_content 'Ordem de serviço encerrada com sucesso.'
    expect(current_path).to eq pending_work_orders_path
  end
  it 'e mantém campos obrigatórios ao encerrar fora do prazo' do
    # Arrange
    user = User.create!(name: 'Maria', email: 'maria@sistemadefrete.com.br', password: '12345678')  
    work_order = WorkOrder.create!(street: 'Av Paulista', city: 'São Paulo', state:'SP', number:'10', customer_name:'Mario', 
      customer_cpf:'12345678909', customer_phone_numer: '11981232345',
      product_name:'Bicicleta', product_weight:5, sku:'123', departure_date:5.days.ago, 
      shipping_expected_date:3.day.ago, warehouse_street:'Rua dos Vianas',
      warehouse_city:'São Bernardo do Campo', warehouse_state:'SP', warehouse_number:'234', 
      distance:11, shipping_method:'Sedex', status:1, shipping_date:Date.today)
    Vehicle.create!(brand_name:'Ford', model:'Fiesta', fabrication_year:'2001', full_capacity:100, license_plate:'ABC-1234', 
        sedex_id: 1, status:2, work_order_id: work_order.id)
    
    # Act
    visit new_user_session_path
    login_as(user)
    visit root_path
    click_on 'Ordens de serviço'
    click_on 'Ver ordens de serviço'
    click_on 'Encerrar ordem de serviço'
    click_on 'Encerrar ordem de serviço'

    # Assert
    expect(page).to have_content 'Motivo do atraso não pode ficar em branco.'
    expect(current_path).not_to eq pending_work_orders_path
  end
  it 'e volta para a tela de ordens de serviço' do
    # Arrange
    user = User.create!(name: 'Maria', email: 'maria@sistemadefrete.com.br', password: '12345678')  
    work_order = WorkOrder.create!(street: 'Av Paulista', city: 'São Paulo', state:'SP', number:'10', customer_name:'Mario', 
      customer_cpf:'12345678909', customer_phone_numer: '11981232345',
      product_name:'Bicicleta', product_weight:5, sku:'123', departure_date:2.days.ago, 
      shipping_expected_date:1.day.ago, warehouse_street:'Rua dos Vianas',
      warehouse_city:'São Bernardo do Campo', warehouse_state:'SP', warehouse_number:'234', 
      distance:11, shipping_method:'Sedex', status:1)
    Expressa.create!(flat_fee:10)
    Sedex.create!(flat_fee:50)
    SedexDez.create!(flat_fee:10)
    Vehicle.create!(brand_name:'Ford', model:'Fiesta', fabrication_year:'2001', full_capacity:100, license_plate:'ABC-1234', 
        sedex_id: 1, status:2, work_order_id: work_order.id)
    # Act
    login_as(user)
    visit root_path
    click_on 'Ordens de serviço'
    click_on 'Ver ordens de serviço'
    click_on 'Encerrar ordem de serviço'
    click_on 'Voltar'
 
    # Assert
    expect(page).to have_content 'Em Progresso'
    expect(page).to have_content "#{work_order.code}"
    expect(page).to have_content 'Encerrar ordem de serviço'
    expect(page).to have_link('Voltar', href: work_orders_path)
    expect(current_path).to eq pending_work_orders_path
  end
end