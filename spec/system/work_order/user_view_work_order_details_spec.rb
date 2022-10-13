require 'rails_helper'

describe 'Usuário vê detalhes de ordem de serviço' do
  it 'em andamento, a partir da tela de ordens de serviço' do
    
    # Arrange
    user = User.create!(name: 'Maria', email: 'maria@sistemadefrete.com.br', password: '12345678', admin:true)
    work_order = WorkOrder.create!(street: 'Av Paulista', city: 'São Paulo', state:'SP', number:'10', customer_name:'Mario', 
                                   customer_cpf:'12345678909', customer_phone_numer: '11981232345', total_price:50,
                                   product_name:'Bicicleta', product_weight:5, sku:'123', departure_date:2.days.ago, 
                                   shipping_expected_date:5.days.from_now, warehouse_street:'Rua dos Vianas',
                                   warehouse_city:'São Bernardo do Campo', warehouse_state:'SP', warehouse_number:'234', 
                                   distance:10, shipping_method:nil, shipping_date: nil, status: 1)
    WorkOrder.create!(street: 'Av São João', city: 'São Paulo', state:'SP', number:'10', customer_name:'Maria', 
                                   customer_cpf:'12345678909', customer_phone_numer: '11981232345', total_price:60,
                                   product_name:'Bicicleta', product_weight:5, sku:'123', departure_date:2.days.ago, 
                                   shipping_expected_date:7.days.from_now, warehouse_street:'Rua dos Vianas',
                                   warehouse_city:'São Bernardo do Campo', warehouse_state:'SP', warehouse_number:'234', 
                                   distance:10, shipping_method:nil, shipping_date: nil, status: 0)
                                   
  
    # Act
    login_as(user)
    visit root_path
    click_on 'Ordens de serviço'
    click_on 'Ver ordens de serviço'
    click_on 'Ver detalhes de ordem de serviço'
 
    # Assert
    expect(page).to have_content 'Endereço Destino:'
    expect(page).to have_content 'Rua dos Vianas, 234, São Bernardo do Campo - SP'
    expect(page).to have_content 'Data de Início:'
    expect(page).to have_content "#{I18n.l(work_order.departure_date)}"
    expect(page).to have_content 'Data prevista de entrega:'
    expect(page).to have_content  "#{I18n.l(work_order.shipping_expected_date)}"
    expect(page).to have_content 'Prazo:'
    expect(page).to have_content '7 dias'
    expect(page).to have_content 'Valor total:'
    expect(page).to have_content 'R$ 50,00'
    expect(page).not_to have_content 'R$ 60,00'
    expect(page).not_to have_content '9 dias'
    expect(page).not_to have_content 'Av São João'
    expect(page).to have_link('Sair', href: destroy_user_session_path)
    expect(current_path).to eq work_order_path(work_order.id)
  end
  it 'e volta para a tela de ordens de serviço' do
    # Arrange
    user = User.create!(name: 'Maria', email: 'maria@sistemadefrete.com.br', password: '12345678', admin:true)
    work_order = WorkOrder.create!(street: 'Av Paulista', city: 'São Paulo', state:'SP', number:'10', customer_name:'Mario', 
                                   customer_cpf:'12345678909', customer_phone_numer: '11981232345', total_price:50,
                                   product_name:'Bicicleta', product_weight:5, sku:'123', departure_date:2.days.ago, 
                                   shipping_expected_date:5.days.from_now, warehouse_street:'Rua dos Vianas',
                                   warehouse_city:'São Bernardo do Campo', warehouse_state:'SP', warehouse_number:'234', 
                                   distance:10, shipping_method:nil, shipping_date: nil, status: 1)
    
    # Act
    login_as(user)
    visit root_path
    click_on 'Ordens de serviço'
    click_on 'Ver ordens de serviço'
    click_on 'Ver detalhes de ordem de serviço'
    click_on 'Voltar'
 
    # Assert
    expect(page).to have_content 'Em Progresso'
    expect(page).to have_content 'Data Prevista de Entrega'
    expect(page).to have_content  "#{I18n.l(work_order.shipping_expected_date)}"
    expect(page).to have_content "#{work_order.code}"
    expect(page).to have_link('Encerrar ordem de serviço')
  end
end