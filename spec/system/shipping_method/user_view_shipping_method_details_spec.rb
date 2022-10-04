require 'rails_helper'

describe 'Usuáro vê detalhes de modalidade de transporte' do
  it 'a partir da tela inicial' do
    # Arrange 
    user = User.create!(name: 'Sergio', email: 'sergio2@sistemadefrete.com.br', password: '12345678', admin:true)
    customer = Customer.create!(name:'João', email:'joão@joão', phone_number:'12345')
    order = Order.create!(customer_id: customer.id, distance:10, departure_date:1.day.from_now, shipping_date:1.day.from_now, shipping_expected_date:2.days.from_now, total_price:10, status:1, sku:'12345', product_name:'Patinete', product_weight:20)
    sm = ShippingMethod.create!(name: 'Sedex', min_distance:'10,20,30', max_distance:'19,29,40', min_weight:'1,2,3', max_weight: '4,5,6', flat_fee: 20, weight_fee:'10,20,30', distance_fee:'40,50,60', order_id:order.id)

    # Act
    login_as(user)
    visit root_path
    click_on 'Modalidades de transporte'
    click_on 'Sedex'
   
    # Assert
    expect(page).to have_content('Modalidade de transporte: Sedex')
    expect(page).to have_content('Configuração de preços por distância')
    expect(page).to have_content('Configuração de preços por peso')
    expect(page).to have_content('Distância mínima')
    expect(page).to have_content('Distância máxima')
    expect(page).to have_content('Peso mínimo')
    expect(page).to have_content('Peso máximo')
    expect(page).to have_content('29 m')
    expect(page).to have_content('6 kg')
    expect(page).to have_content('Taxa fixa: R$ 20')
    expect(page).to have_link('Alterar status')
    expect(page).to have_link('Voltar')
  end
  it 'e volta para a tela inicial' do
    # Arrange 
    user = User.create!(name: 'Sergio', email: 'sergio@sistemadefrete.com.br', password: '12345678', admin:true)
    customer = Customer.create!(name:'João', email:'joão@joão', phone_number:'12345')
    order = Order.create!(customer_id: customer.id, distance:10, departure_date:1.day.from_now, shipping_date:1.day.from_now, shipping_expected_date:2.days.from_now, total_price:10, status:1, sku:'12345', product_name:'Patinete', product_weight:20)
    ShippingMethod.create!(name: 'Sedex', min_distance:'10,20,30', max_distance:'19,29,40', min_weight:'10,20,30', max_weight: '19,29,40', flat_fee: 50, weight_fee:'10,20,30', distance_fee:'40,50,60', order_id:order.id)

    # Act
    login_as(user)
    visit root_path
    click_on 'Modalidades de transporte'
    click_on 'Sedex'
    click_on 'Voltar'

    # Assert
    expect(page).to have_content('Modalidades de transporte')
    expect(page).to have_content('Sedex')
    expect(page).to have_content('Status')
    expect(page).to have_content('Ativo')
    expect(page).not_to have_content('Modalidade de transporte')
    expect(page).to have_link('Cadastrar modalidade de transporte')
    expect(current_path).to eq(shipping_methods_path)
  end
end