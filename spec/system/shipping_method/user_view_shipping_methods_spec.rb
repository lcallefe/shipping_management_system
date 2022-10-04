require 'rails_helper'

describe 'Usuáro vê pedidos' do
  it 'a partir da tela principal' do
    # Arrange 
    user = User.create!(name: 'Sergio', email: 'serginho@sistemadefrete.com.br', password: '12345678', admin:false)
    customer = Customer.create!(name:'João', email:'joão@joão', phone_number:'12345', cpf:'345456567')
    order = Order.create!(customer_id: customer.id, distance:10, departure_date:1.day.from_now, shipping_date:1.day.from_now, shipping_expected_date:2.days.from_now, total_price:10, status:1, sku:'12345', product_name:'Patinete', product_weight:20)
    departure_place = Address.create!(street:'rua dos bobos', number:'0', city:'Rio Branco', state:'Acre', address_complement: 'S/N', customer_id:nil, order_id:order.id)
    destination = Address.create!(street:'av paulista', number:'34', city:'São Paulo', state:'SP', address_complement: 'S/N', customer_id:customer.id, order_id:nil)
    ShippingMethod.create!(name: 'Sedex', min_distance_price:'10,20,30', max_distance_price:'19,29,40', min_weight:'1,2,3', max_weight: '4,5,6', flat_fee: 20, weight_fee:'10,20,30', min_distance_deadline:'20,30,40', max_distance_deadline:'29,39,50', delivery_time:'24,48,72', distance_fee:'40,50,60', order_id:order.id)
    ShippingMethod.create!(name: 'Sedex 10', min_distance_price:'11,21,31', max_distance_price:'20,30,40', min_weight:'10,20,30', max_weight: '19,29,40', flat_fee: 50, weight_fee:'10,20,30', distance_fee:'40,50,60', min_distance_deadline:'20,30,40', max_distance_deadline:'29,39,50', delivery_time:'24,48,72', status:0, order_id:order.id)

    # Act
    login_as(user)
    visit root_path
    click_on 'Modalidades de transporte'

    # Assert
    expect(page).to have_content('Modalidades de transporte')
    expect(page).to have_content('Sedex')
    expect(page).to have_content('Sedex 10')
    expect(page).to have_content('Status')
    expect(page).to have_content('Ativo')
    expect(page).to have_content('Inativo')
    expect(page).not_to have_link('Cadastrar modalidade de transporte')
    expect(current_path).to eq(shipping_methods_path)
  end
  it 'e volta para a tela inicial' do
    # Arrange 
    user = User.create!(name: 'Sergio', email: 'sergio@sistemadefrete.com.br', password: '12345678')
    customer = Customer.create!(name:'João', email:'joão@joão', phone_number:'12345')
    order = Order.create!(customer_id: customer.id, distance:10, departure_date:1.day.from_now, shipping_date:1.day.from_now, shipping_expected_date:2.days.from_now, total_price:10, status:1, sku:'12345', product_name:'Patinete', product_weight:20)
    departure_place = Address.create!(street:'rua dos bobos', number:'0', city:'Rio Branco', state:'Acre', address_complement: 'S/N', customer_id:nil, order_id:order.id)
    destination = Address.create!(street:'av paulista', number:'34', city:'São Paulo', state:'SP', address_complement: 'S/N', customer_id:customer.id, order_id:nil)
    ShippingMethod.create!(name: 'Sedex', min_distance_price:'10,20,30', max_distance_price:'19,29,40', min_weight:'1,2,3', max_weight: '4,5,6', flat_fee: 20, weight_fee:'10,20,30', min_distance_deadline:'20,30,40', max_distance_deadline:'29,39,50', delivery_time:'24,48,72', distance_fee:'40,50,60', order_id:order.id)

    # Act
    login_as(user)
    visit root_path
    click_on 'Modalidades de transporte'
    click_on 'Voltar'

    # Assert
    expect(page).not_to have_content('Status')
    expect(page).to have_content('Selecione a opção desejada:')
    expect(current_path).to eq(root_path)
  end
  it 'e não há modalidades de transporte cadastradas' do
    # Arrange 
    user = User.create!(name: 'Sergio', email: 'sergio@sistemadefrete.com.br', password: '12345678')

    # Act
    login_as(user)
    visit root_path
    click_on 'Modalidades de transporte'
 
    # Assert
    expect(page).not_to have_content("Veículo")
    expect(page).not_to have_content("Status")
    expect(page).to have_content("Não há modalidades de transporte cadastradas")
    expect(current_path).to eq(shipping_methods_path)
  end
end