require 'rails_helper'

describe 'Usuáro vê modalidade de transporte ' do
  it 'a partir da tela principal' do

    user = User.create!(email:'marianadasilva@sistemadefrete.com.br', name:'Mariana', password:'C3b0l@0710')
    sm = ShippingMethod.create!(flat_fee:45, name:'Ultra Plus', min_distance:5, max_distance:20, min_weight:5, max_weight:50, 
                                min_price:5, max_price:50, min_delivery_time:1, max_delivery_time:240)
    DeliveryTimeDistance.create!(min_distance: 10, max_distance: 20, delivery_time: 15, shipping_method_id:sm.id)
    PriceDistance.create!(min_distance:10, max_distance:20, price:40, shipping_method_id:sm.id)
    PriceWeight.create!(min_weight:5, max_weight:15, price:25, shipping_method_id:sm.id)
                    
    login_as(user)
    visit root_path
    click_on 'Modalidades de transporte'
    click_on 'Ver detalhes'
         
    expect(page).to have_content("Modalidade de transporte Ultra Plus")
    expect(page).to have_content('Configuração de preços por distância')
    expect(page).to have_content('Peso | Valor por km')
    expect(page).to have_content('Distância mínima')
    expect(page).to have_content('Distância máxima')
    expect(page).to have_content('Preço')
    expect(page).to have_content('Prazo')
    expect(page).to have_content('Status: Ativo')
    expect(page).to have_content('Taxa fixa: R$ 45,00')
    expect(page).to have_link('Sair', href: destroy_user_session_path)
    expect(page).to have_link('Voltar', href: root_path)
    expect(current_path).to eq(shipping_method_path(sm.id))
  end
  
  it 'e volta para a tela inicial' do

    user = User.create!(email:'marianadasilva_user@sistemadefrete.com.br', name:'Mariana', password:'123G01@b@')
    sm = ShippingMethod.create!(flat_fee:45, name:'Shipping Method', min_distance:5, max_distance:20, min_weight:5, max_weight:50, 
                                min_price:5, max_price:50, min_delivery_time:1, max_delivery_time:240)
    DeliveryTimeDistance.create!(min_distance: 10, max_distance: 20, delivery_time: 15, shipping_method_id:sm.id)
    PriceDistance.create!(min_distance:10, max_distance:20, price:40, shipping_method_id:sm.id)
    PriceWeight.create!(min_weight:5, max_weight:15, price:25, shipping_method_id:sm.id)

    login_as(user)
    visit root_path
    click_on 'Modalidades de transporte'
    click_on 'Ver detalhes'
    click_on 'Voltar'

    expect(page).to have_content('Olá Mariana')
    expect(page).to have_content('Ordens de serviço')
    expect(page).to have_content('Veículos')
    expect(page).to have_link('Sair', href: destroy_user_session_path)
    expect(page).not_to have_link('Voltar')
    expect(page).not_to have_content('Shipping Method')
    expect(current_path).to eq(root_path)
  end
end